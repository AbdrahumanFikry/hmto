import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:senior/models/billProduct.dart';
import 'package:senior/models/httpExceptionModel.dart';
import 'package:senior/models/oldInvoice.dart';
import 'package:senior/models/pricePlan.dart';
import 'package:senior/models/qrResult.dart';
import 'package:senior/models/reternedProduct.dart';
import 'package:senior/models/startDaySalles.dart';
import 'package:senior/models/stores.dart';
import 'package:senior/models/target.dart';
import 'package:senior/models/debitInvoices.dart';
import 'package:senior/senior/sellsTarget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class SellsData with ChangeNotifier {
  String token;
  int userId;
  String userName;
  int businessId;
  String date;
  String locationId;
  String transactionId;
  int chosenPricePlan = 0;
  int chosenTaxPlan = 0;
  bool donePricePlan = false;
  bool invoiceError = false;
  int invoiceId = 0;
  StartDayData startDayData;
  QrResult qrResult;
  Stores stores;
  double sale = 0.0;
  double range = 1.0;
  double priceAfterTax = 0.0;
  OldInvoices oldInvoices;
  DebitInvoicesModel debitInvoices;
  List<BillProduct> bill = [];
  List<CarProduct> loadedItems = [];
  List<Products> billProducts = [];
  List<ReturnedProduct> returnedBill = [];
  List<CarProduct> printedBill = [];
  TargetSells target;
  PriceTaxesPlan priceTaxesPlan;

  //-------------------------- Fetch Data --------------------------------------
  Future<bool> fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    token = extractedUserData['token'];
    userId = extractedUserData['userId'];
    businessId = extractedUserData['businessId'];
    userName = extractedUserData['userName'];
    if (!prefs.containsKey('startDayData')) {
      return false;
    }
    locationId = prefs.getString('locationId');
    notifyListeners();
    return true;
  }

  //------------------------------ check Day -----------------------------------
  Future<void> checkDay() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('startDayData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('startDayData')) as Map<String, Object>;
    date = extractedUserData['date'];
    notifyListeners();
    return true;
  }

  //------------------------- Fetch start day data -----------------------------
  Future<void> fetchStartDayData() async {
    await fetchUserData();
    const url = 'https://api.hmto-eleader.com/api/sellsman/account';
    final prefs = await SharedPreferences.getInstance();
    try {
      var body = {
        "user_id": userId.toString(),
      };
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
      };
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      print("Response :" + response.body.toString());
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        startDayData = StartDayData.fromJson(responseData);
        final userData = json.encode(
          {
            'data': startDayData.productsInOwnCar,
          },
        );
        prefs.setString('cartItems', userData);
        prefs.setString('locationId', startDayData.locationId.toString());
        notifyListeners();
        return true;
      } else {
        throw HttpException(message: responseData['error']);
      }
    } catch (error) {
      print('Request Error :' + error.toString());
      throw error;
    }
  }

  //------------------------------ Scan store ----------------------------------
  Future<void> scanStore({String qrData}) async {
    oldInvoices = null;
    await fetchUserData();
    const url = 'https://api.hmto-eleader.com/api/sellsman/scanStore';
    try {
      var body = {
        "qrcode": qrData,
        "user_id": userId.toString(),
      };

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
      };
      final response = await http.post(
        url,
        body: body,
        headers: headers,
      );
      print("Response :" + response.body.toString());
      final Map responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        qrResult = QrResult.fromJson(responseData);
        notifyListeners();
        return true;
      } else {
        throw HttpException(message: responseData['message']);
      }
    } catch (error) {
      print('Request Error :' + error.toString());
      throw error;
    }
  }

  //------------------------------ Scan store ----------------------------------
  Future<void> allStores() async {
    await fetchUserData();
    const url = 'https://api.hmto-eleader.com/api/sellsman/all-stores';
    try {
      var body = json.encode({
        "user_id": userId,
      });

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
      };
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      print("Response :" + response.body.toString());
      final Map responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        stores = Stores.fromJson(responseData);
        notifyListeners();
        return true;
      } else {
        throw HttpException(message: responseData['message']);
      }
    } catch (error) {
      print('Request Error :' + error.toString());
      throw error;
    }
  }

  //--------------------------- Add product to bill ----------------------------
  Future<void> addItemToBill({String serialNumber}) async {
    loadedItems = [];
    await fetchCarProduct();
    int index = loadedItems.indexWhere((i) => i.serialNumber == serialNumber);
    int billIndex =
        bill.indexWhere((i) => i.productId == loadedItems[index].productId);
//    print('::::::::::' + billIndex.toString());
    if (billIndex != -1) {
      throw HttpException(message: tr('errors.exist'));
    }
    try {
      bill.add(
        BillProduct(
          productId: loadedItems[index].productId,
          unitPrice: loadedItems[index].priceForEach,
          quantity: 1,
          unitPriceBeforeDiscount: loadedItems[index].priceForEach,
          unitPriceIncTax: loadedItems[index].priceForEach,
        ),
      );
    } catch (error) {
      throw HttpException(message: tr('errors.notFound'));
    }
    returnTotal();
    notifyListeners();
  }

  //--------------------- Fetch data from SharedPreferences --------------------
  Future<void> fetchCarProduct() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('cartItems')) {
      return [];
    }
    final responseData =
        json.decode(prefs.getString('cartItems')) as Map<String, dynamic>;
    loadedItems = [];
    responseData['data'].forEach((itemData) {
      List<GroupPriceStartDay> groupPrice = new List<GroupPriceStartDay>();
      if (itemData['group_price'] != null) {
        itemData['group_price'].forEach((v) {
          groupPrice.add(new GroupPriceStartDay.fromJson(v));
        });
      }
      loadedItems.add(CarProduct(
        productId: itemData['product_id'],
        productName: itemData['product_name'],
        serialNumber: itemData['Sku'],
        quantity: itemData['quantity'],
        priceForEach: itemData['default_sell_price'],
        groupPrice: groupPrice,
      ));
    });
//    print('Car products :' + json.encode({'carProducts': loadedItems}));
    notifyListeners();
    return loadedItems;
  }

  //------------------------- Remove amount from bill --------------------------
  void removeAmountFromBill({int id}) {
    int index = bill.indexWhere((item) => item.productId == id);
    if (index != -1 && bill[index].quantity != 1) {
      bill[index].quantity--;
      returnTotal();
      notifyListeners();
    }
  }

  //--------------------------- Add amount from bill ---------------------------
  Future<void> addAmountToBill({int id}) async {
    loadedItems = [];
    await fetchCarProduct();
    int billIndex = bill.indexWhere((item) => item.productId == id);
    int carIndex = loadedItems.indexWhere((item) => item.productId == id);
    if (billIndex != -1 &&
        carIndex != -1 &&
        loadedItems[carIndex].quantity > bill[billIndex].quantity) {
      bill[billIndex].quantity++;
      returnTotal();
      notifyListeners();
    } else {
      throw HttpException(
        message: 'errors.noMore'.tr(args: [loadedItems[carIndex].productName]),
      );
    }
  }

  //---------------------- Add Range amount from bill --------------------------
  Future<void> addRangeAmountToBill({String serialNumber}) async {
    loadedItems = [];
    await fetchCarProduct();
    int carIndex =
        loadedItems.indexWhere((item) => item.serialNumber == serialNumber);
    int billIndex = bill.indexWhere(
        (item) => item.productId == loadedItems[carIndex].productId);
    if (billIndex != -1 &&
        carIndex != -1 &&
        loadedItems[carIndex].quantity > bill[billIndex].quantity) {
      bill[billIndex].quantity = range.round();
      resetRange();
      returnTotal();
      notifyListeners();
    } else {
      throw HttpException(
        message: 'errors.noMore'.tr(args: [loadedItems[carIndex].productName]),
      );
    }
  }

  //------------------------- Remove product from bill -------------------------
  void removeProductFromBill({int id}) {
    int index = bill.indexWhere((item) => item.productId == id);
    if (index != -1) {
      bill.removeAt(index);
      returnTotal();
      notifyListeners();
    }
  }

  //------------------------------ Total bill ----------------------------------
  double returnTotal() {
    double sum = 0;
    bill.forEach((item) {
      sum = sum + (item.unitPrice * item.quantity);
    });
    sum = sum - sale;
//    print('::::::::::' + priceTaxesPlan.toString());
    if (priceTaxesPlan != null) {
      priceAfterTax =
          (sum * priceTaxesPlan.taxes[chosenTaxPlan].amount / 100) + sum;
    }
    return sum;
  }

  //-------------------------- Total bill after tax ----------------------------
  void applySale({double value}) {
    sale = value;
    notifyListeners();
  }

  //---------------------------- Balance car products---------------------------
  Future<void> finishBill() async {
    await addItemsToPrintedBill();
    try {
      loadedItems = [];
      await fetchCarProduct();
      bill.forEach((billItem) {
        int index = loadedItems
            .indexWhere((cartItem) => cartItem.productId == billItem.productId);
        if (billItem.quantity == loadedItems[index].quantity) {
          loadedItems.removeAt(index);
        } else {
          loadedItems[index].quantity =
              loadedItems[index].quantity - billItem.quantity;
        }
      });
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'data': loadedItems,
        },
      );
      prefs.setString('cartItems', userData);
      bill = [];
      priceAfterTax = 0.0;
//      print('Car products :' + json.encode({'carProducts': loadedItems}));
      notifyListeners();
    } catch (error) {
      throw HttpException(message: tr('errors.noBalance'));
    }
  }

  //------------------------------- Pay cash -----------------------------------
  Future<void> payCash({int storeId, double total, String sale}) async {
    await fetchUserData();
    const url = 'https://api.hmto-eleader.com/api/sellsman/transaction/cache';
    try {
      var body = {
//        "created_by": userId.toString(),
        "business_id": businessId.toString(),
        "location_id": locationId,
        "contact_id": storeId.toString(),
        "total_before_tax": (total - double.tryParse(sale)).toString(),
        "final_total": priceAfterTax.toStringAsFixed(2).toString(),
        "products": json.encode(bill),
        "tax_id": priceTaxesPlan.taxes[chosenTaxPlan].id.toString(),
        "tax_amount": (priceTaxesPlan.taxes[chosenTaxPlan].amount * total / 100)
            .toString(),
        "discount_amount": sale,
      };

      Map<String, String> headers = {
        "Authorization": "Bearer $token",
      };
//      print('Request body : ' + body);
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      print("Response :" + response.body.toString());
      final Map responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        //remove items from car and balance the products
        transactionId = responseData['transaction_id'].toString();
        await finishBill();
        notifyListeners();
        return true;
      } else {
        throw HttpException(message: responseData['message']);
      }
    } catch (error) {
      print('Request Error :' + error.toString());
      throw error;
    }
  }

  //------------------------------- Pay debit ----------------------------------
  Future<void> payDebit({
    int storeId,
    double total,
    String paid,
    String sale,
  }) async {
    await fetchUserData();
    const url = 'https://api.hmto-eleader.com/api/sellsman/debit';
    try {
      var body = {
//        "created_by": userId.toString(),
        "business_id": businessId.toString(),
        "location_id": locationId,
        "contact_id": storeId.toString(),
        "total_before_tax": (total - double.tryParse(sale)).toString(),
        "final_total": priceAfterTax.toStringAsFixed(2).toString(),
        "products": json.encode(bill),
        "amout_paid": paid,
        "tax_amount": (priceTaxesPlan.taxes[chosenTaxPlan].amount * total / 100)
            .toString(),
        "tax_id": priceTaxesPlan.taxes[chosenTaxPlan].id.toString(),
        "discount_amount": sale,
      };

      Map<String, String> headers = {
        "Authorization": "Bearer $token",
      };
      print('Request body : ' + json.encode(body));
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      print("Response :" + response.body.toString());
      final Map responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        //remove items from car and balance the products
        transactionId = responseData['transaction_id'].toString();
        await finishBill();
        notifyListeners();
        return true;
      } else {
        throw HttpException(message: responseData['message']);
      }
    } catch (error) {
      print('Request Error :' + error.toString());
      throw error;
    }
  }

  //--------------------------- Fetch last 3 invoice ---------------------------
  Future<void> fetchOldInvoices({int storeId}) async {
    await fetchUserData();
    const url = 'https://api.hmto-eleader.com/api/sellsman/last-invoice';
    try {
      var body = {
        "location_id": locationId,
        "contact_id": storeId.toString(),
      };

      Map<String, String> headers = {
        "Authorization": "Bearer $token",
      };
      print('Request body : ' + json.encode(body));
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      print("Response :" + response.body.toString());
      final Map responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        oldInvoices = OldInvoices.fromJson(responseData);
        invoiceError = false;
        notifyListeners();
        return true;
      } else {
        invoiceError = true;
        throw HttpException(message: responseData['message']);
      }
    } catch (error) {
      invoiceError = true;
      print('Request Error :' + error.toString());
      throw error;
    }
  }

  //--------------------------- return old products ----------------------------
  Future<void> returnProducts({int storeId, double total}) async {
    await fetchUserData();
    const url = 'https://api.hmto-eleader.com/api/sellsman/return-sell';
    try {
      var body = {
        "business_id": businessId.toString(),
        "location_id": locationId,
        "contact_id": storeId.toString(),
        "created_by": userId.toString(),
        "total_before_tax": total.toString(),
        "final_total": total.toString(),
        "return_parent_id": invoiceId.toString(),
        "products": json.encode(returnedBill),
      };

      Map<String, String> headers = {
        "Authorization": "Bearer $token",
      };
      print('Request body : ' + json.encode(body));
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      print("Response :" + response.body.toString());
      final Map responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        await finishReturnedInvoice();
        notifyListeners();
        return true;
      } else {
        throw HttpException(message: responseData['message']);
      }
    } catch (error) {
      print('Request Error :' + error.toString());
      throw error;
    }
  }

  //------------------- Add product to returned invoice ------------------------
  Future<void> addItemToReturnedInvoice({String serialNumber}) async {
    loadedItems = [];
    await fetchCarProduct();
    int index = loadedItems.indexWhere((i) => i.serialNumber == serialNumber);
    if (index != -1) {
      int billIndex = returnedBill
          .indexWhere((i) => i.productId == loadedItems[index].productId);
      if (billIndex != -1) {
        throw HttpException(message: tr('errors.exist'));
      } else {
        int oldInvoiceIndex = billProducts
            .indexWhere((item) => item.id == loadedItems[index].productId);
        if (oldInvoiceIndex != -1) {
          try {
            returnedBill.add(
              ReturnedProduct(
                productId: billProducts[oldInvoiceIndex].id,
                quantity: 1,
              ),
            );
          } catch (error) {
            throw HttpException(message: tr('errors.notFound'));
          }
        } else {
          throw HttpException(message: tr('errors.notFound'));
        }
      }
    } else {
      throw HttpException(message: tr('errors.notFound'));
    }
    notifyListeners();
  }

  //------------------ Remove amount from returned invoice ---------------------
  void removeAmountFromReturnedInvoice({int id}) {
    int index = returnedBill.indexWhere((item) => item.productId == id);
    if (index != -1 && returnedBill[index].quantity != 1) {
      returnedBill[index].quantity--;
      notifyListeners();
    }
  }

  //-------------------- Add amount to returned invoice ------------------------
  Future<void> addAmountToReturnedInvoice({int id}) async {
    int billIndex = returnedBill.indexWhere((item) => item.productId == id);
    int oldInvoiceIndex = billProducts.indexWhere((item) => item.id == id);
    if (billIndex != -1 &&
        oldInvoiceIndex != -1 &&
        billProducts[oldInvoiceIndex].quantity >
            returnedBill[billIndex].quantity) {
      returnedBill[billIndex].quantity++;
      notifyListeners();
    } else {
      throw HttpException(
        message:
            'errors.noMore'.tr(args: [billProducts[oldInvoiceIndex].product]),
      );
    }
  }

  //----------------- Add range amount to returned invoice ---------------------
  Future<void> addRangeAmountToReturnedInvoice({String serialNumber}) async {
    loadedItems = [];
    await fetchCarProduct();
    int carIndex =
        loadedItems.indexWhere((item) => item.serialNumber == serialNumber);
    int billIndex = returnedBill.indexWhere(
        (item) => item.productId == loadedItems[carIndex].productId);
    int oldInvoiceIndex = billProducts
        .indexWhere((item) => item.id == loadedItems[carIndex].productId);
    if (billIndex != -1 &&
        oldInvoiceIndex != -1 &&
        billProducts[oldInvoiceIndex].quantity >
            returnedBill[billIndex].quantity) {
      returnedBill[billIndex].quantity = range.round();
      resetRange();
      notifyListeners();
    } else {
      throw HttpException(
        message:
            'errors.noMore'.tr(args: [billProducts[oldInvoiceIndex].product]),
      );
    }
  }

  //------------------ Remove product from returned invoice --------------------
  void removeProductFromReturnedInvoice({int id}) {
    int index = returnedBill.indexWhere((item) => item.productId == id);
    if (index != -1) {
      returnedBill.removeAt(index);
      notifyListeners();
    }
  }

  //----------------------------- Change range ---------------------------------
  void changeRange({double value}) {
    range = value;
    notifyListeners();
  }

//-------------------------------- Reset range ---------------------------------
  void resetRange() {
    range = 0.0;
    notifyListeners();
  }

//---------------------------- Balance car products --------------------------
  Future<void> finishReturnedInvoice() async {
    try {
      loadedItems = [];
      await fetchCarProduct();
      returnedBill.forEach((billItem) {
        int index = loadedItems
            .indexWhere((cartItem) => cartItem.productId == billItem.productId);
        if (index != -1) {
          loadedItems[index].quantity =
              loadedItems[index].quantity + billItem.quantity;
        } else {
          loadedItems.add(
            CarProduct(
              productId: billItem.productId,
              quantity: billItem.quantity,
              serialNumber: '****',
              priceForEach: 0.0,
              productName: tr('sells_store.return'),
            ),
          );
        }
      });
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'data': loadedItems,
        },
      );
      prefs.setString('cartItems', userData);
      returnedBill = [];
//      print('Car products :' + json.encode({'carProducts': loadedItems}));
      notifyListeners();
    } catch (error) {
      throw HttpException(message: tr('errors.noBalance'));
    }
  }

  //---------------------- Add product to printed bill -------------------------
  Future<void> addItemsToPrintedBill() async {
    printedBill = [];
    loadedItems = [];
    await fetchCarProduct();
    bill.forEach((billItem) {
      int index = loadedItems
          .indexWhere((cartItem) => cartItem.productId == billItem.productId);
      if (index != -1) {
        printedBill.add(
          CarProduct(
            productId: loadedItems[index].productId,
            serialNumber: loadedItems[index].serialNumber,
            productName: loadedItems[index].productName,
            priceForEach: billItem.unitPrice,
            quantity: billItem.quantity,
          ),
        );
      }
    });
    print('PrintedBillItems : ' + json.encode(printedBill));
    notifyListeners();
  }

  //---------------------------- Fetch Target ----------------------------------
  Future<void> fetchTarget() async {
    await fetchUserData();
    final url = 'https://api.hmto-eleader.com/api/sellsman/target';
    try {
      final response = await http.post(url, headers: {
//        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      print("Response :" + response.body.toString());
      final Map responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        target = TargetSells.fromJson(responseData);
        return true;
      } else {
        throw HttpException(message: responseData['error']);
      }
    } catch (error) {
      print('Request Error :' + error.toString());
      throw error;
    }
  }

  //------------------------------ Total bill ----------------------------------
  double returnTotalCart() {
    double sum = 0;
    loadedItems.forEach((item) {
      sum = sum + (item.priceForEach * item.quantity);
    });
//    print('Total price : ' + sum.toString());
    return sum;
  }

  //------------------------- Fetch debit invoices -----------------------------
  Future<void> fetchDebitInvoices({int storeId}) async {
    await fetchUserData();
    const url = 'https://api.hmto-eleader.com/api/sellsman/get/debit';
    try {
      var body = {
        "contact_id": storeId.toString(),
      };
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
      };
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      print("Response :" + response.body.toString());
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        debitInvoices = DebitInvoicesModel.fromJson(responseData);
        notifyListeners();
        return true;
      } else {
        throw HttpException(message: responseData['error']);
      }
    } catch (error) {
      print('Request Error :' + error.toString());
      throw error;
    }
  }

  //------------------------- Pay old debit invoice ----------------------------
  Future<void> payOldDebitInvoice(
      {int transactionId, String amountPaid}) async {
    await fetchUserData();
    const url = 'https://api.hmto-eleader.com/api/sellsman/paid/debit';
    try {
      var body = {
        "transaction_id": transactionId.toString(),
        "amount_paid": amountPaid,
      };
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
      };
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      print("Response :" + response.body.toString());
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        notifyListeners();
        return true;
      } else {
        throw HttpException(message: responseData['error']);
      }
    } catch (error) {
      print('Request Error :' + error.toString());
      throw error;
    }
  }

  //--------------------------- Fetch price plan -------------------------------
  Future<void> fetchPricePlan() async {
    await fetchUserData();
    const url = 'https://api.hmto-eleader.com/api/price_group';
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
      };
      final response = await http.post(
        url,
        headers: headers,
      );
      print("Response :" + response.body.toString());
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        priceTaxesPlan = PriceTaxesPlan.fromJson(responseData);
        notifyListeners();
        return true;
      } else {
        throw HttpException(message: responseData['error']);
      }
    } catch (error) {
      print('Request Error :' + error.toString());
      throw error;
    }
  }

  //--------------------------- Choose price plan ------------------------------
  void choosePricePlan({int value}) {
    chosenPricePlan = value;
    notifyListeners();
  }

  //---------------------------- Choose tax plan -------------------------------
  void chooseTaxPlan({int value}) {
    chosenTaxPlan = value;
    notifyListeners();
  }

  //------------------------------- Done plans ---------------------------------
  void donePlans() async {
    loadedItems = [];
    await fetchCarProduct();
    int priceId = priceTaxesPlan.groupPrice[chosenPricePlan].id;
    bill.forEach((item) {
      int targetIndex = loadedItems
          .indexWhere((carItem) => item.productId == carItem.productId);
      if (targetIndex != -1) {
        item.unitPrice = loadedItems[targetIndex]
            .groupPrice
            .firstWhere((groupPrice) => groupPrice.id == priceId)
            .priceIncTax;
      } else {
        throw HttpException(
            message: 'error adding new price ,could not find the right price');
      }
    });
    sale = 0.0;
    donePricePlan = true;
    notifyListeners();
  }

  //------------------------------- Done plans ---------------------------------
  void clearAll() {
    donePricePlan = false;
    chosenPricePlan = 0;
    chosenTaxPlan = 0;
    priceTaxesPlan = null;
    notifyListeners();
  }
}
