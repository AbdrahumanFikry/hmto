import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:senior/models/billProduct.dart';
import 'package:senior/models/debitInvoices.dart';
import 'package:senior/models/httpExceptionModel.dart';
import 'package:senior/models/oldInvoice.dart';
import 'package:senior/models/pricePlan.dart';
import 'package:senior/models/qrResult.dart';
import 'package:senior/models/reternedProduct.dart';
import 'package:senior/models/startDaySalles.dart';
import 'package:senior/models/stores.dart';
import 'package:senior/models/target.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/alertDialog.dart';

class SellsData with ChangeNotifier {
  var dio = Dio();
  String token;
  int userId;
  String userName;
  int businessId;
  String date;
  String locationId;
  String storeCode = '0';
  double latCache = 31.0000, lanCache = 31.0000;
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
  double allRange = 0.0;
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
  List<CarProduct> billItemRef = [];

  // Units targetUnit;
  CarProduct targetProduct;
  bool isLoading = false;
  int maxVal = 0;

  void loading(bool state) {
    isLoading = state;
    notifyListeners();
  }

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
    loading(true);
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
        await fetchCarProduct();
        double totalCarMoney = returnTotalCart();
        prefs.setDouble('totalCarMoney', totalCarMoney);
        notifyListeners();
        loading(false);
        return true;
      } else {
        loading(false);
        throw HttpException(message: responseData['error']);
      }
    } catch (error) {
      loading(false);
      print('Request Error :' + error.toString());
      throw error;
    }
  }

  //------------------------------ Scan store ----------------------------------
  Future<void> scanStore({String qrData, double lat, double lng}) async {
    storeCode = 'code unAvailable';
    oldInvoices = null;
    bill = [];
    lanCache = lat;
    lanCache = lng;
    await fetchUserData();
    storeCode = qrData;
    const url = 'https://api.hmto-eleader.com/api/sellsman/scanStore';
    try {
      print('::::::::::::lat :' + lat.toString() + '-long :' + lng.toString());
      var body = {
        "qrcode": qrData,
        "lat": lat.toString(),
        "lan": lng.toString(),
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
        if (response.body.contains('401')) {
          throw HttpException(message: ' هذا المتجر ليس ضمن التارجت المحقق لك');
        }
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
  Future<void> addItemToBill(
      {String serialNumber, BuildContext context}) async {
    loadedItems = [];
    maxVal = 0;
    // targetUnit = null;
    targetProduct = null;
    await fetchCarProduct();
    for (var item in loadedItems) {
      if (item.serialNumber == serialNumber) {
        var selectedUnit = await showUnits(item, context);
        print('AddItemToBill :::' + selectedUnit.toString());
        // targetUnit = Units(
        //   id: item.productId,
        //   actualName: item.productName,
        //   shortName: item.productName,
        //   sku: serialNumber,
        //   unitCount: 1,
        // );
        if (selectedUnit != null && selectedUnit == item.serialNumber) {
          targetProduct = item;
          maxVal = item.quantity.round();
          print('Target product ::::: ' + targetProduct.productName);
          if (targetProduct != null) break;
        } else {
          serialNumber = selectedUnit;
          print('SerialNumber :' + serialNumber);
          for (var unit in item.units) {
            if (unit.sku == serialNumber) {
              // targetUnit = unit;
              targetProduct = CarProduct(
                productId: unit.id,
                serialNumber: unit.sku,
                productName: unit.actualName,
                quantity: (item.quantity / unit.unitCount).round(),
                units: [],
                groupPrice: item.groupPrice,
                priceForEach: (unit.unitCount * item.priceForEach),
              );
              print('Price for piece : ' + item.priceForEach.toString());
              print('Price for all : ' +
                  (unit.unitCount * item.priceForEach).toString());
              maxVal = (item.quantity / unit.unitCount).round();
              if (targetProduct != null) break;
            }
          }
        }
      } else if (item?.units != null) {
        for (var unit in item.units) {
          if (unit.sku == serialNumber) {
            // targetUnit = unit;
            targetProduct = CarProduct(
              productId: unit.id,
              serialNumber: unit.sku,
              productName: unit.actualName,
              quantity: (item.quantity / unit.unitCount).round(),
              units: [],
              groupPrice: item.groupPrice,
              priceForEach: (unit.unitCount * item.priceForEach),
            );
            print('Price for piece : ' + item.priceForEach.toString());
            print('Price for all : ' +
                (unit.unitCount * item.priceForEach).toString());
            maxVal = (item.quantity / unit.unitCount).round();
            if (targetProduct != null) break;
          }
        }
      }
    }
    // int index = loadedItems.indexWhere((i) => i.serialNumber == serialNumber);
    int billIndex =
        bill.indexWhere((i) => i.productId == targetProduct?.productId);
    if (billIndex != -1) {
      throw HttpException(message: tr('errors.exist'));
    }
    try {
      bill.add(
        BillProduct(
          productId: targetProduct.productId,
          unitPrice: targetProduct.priceForEach,
          quantity: 1,
          unitPriceBeforeDiscount: targetProduct.priceForEach,
          unitPriceIncTax: targetProduct.priceForEach,
        ),
      );
    } catch (error) {
      print(error.toString());
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
      List<Units> units = new List<Units>();
      if (itemData['group_price'] != null) {
        itemData['group_price'].forEach((v) {
          groupPrice.add(new GroupPriceStartDay.fromJson(v));
        });
      }
      if (itemData['units'] != null) {
        itemData['units'].forEach((v) {
          units.add(new Units.fromJson(v));
        });
      }
      loadedItems.add(CarProduct(
        productId: itemData['product_id'],
        productName: itemData['product_name'],
        serialNumber: itemData['Sku'],
        quantity: itemData['quantity'],
        priceForEach: itemData['default_sell_price'],
        groupPrice: groupPrice,
        units: units,
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
    CarProduct targetAmountProduct;
    for (var item in loadedItems) {
      if (item.productId == id) {
        targetAmountProduct = item;
        maxVal = item.quantity.round();
        print('Target product ::::: ' + targetProduct.productName);
        if (targetProduct != null) break;
      } else if (item?.units != null) {
        for (var unit in item.units) {
          if (unit.id == id) {
            targetAmountProduct = CarProduct(
              productId: unit.id,
              serialNumber: unit.sku,
              productName: unit.actualName,
              quantity: (item.quantity / unit.unitCount).round(),
              units: [],
              groupPrice: item.groupPrice,
              priceForEach: (unit.unitCount * item.priceForEach),
            );
            print('Price for piece : ' + item.priceForEach.toString());
            print('Price for all : ' +
                (unit.unitCount * item.priceForEach).toString());
            maxVal = (item.quantity / unit.unitCount).round();
            if (targetProduct != null) break;
          }
        }
      }
    }
    int billIndex = bill.indexWhere((item) => item.productId == id);
    // int carIndex = loadedItems.indexWhere((item) => item.productId == id);
    if (billIndex != -1 &&
        targetAmountProduct != null &&
        targetAmountProduct.quantity > bill[billIndex].quantity) {
      bill[billIndex].quantity++;
      returnTotal();
      notifyListeners();
    } else {
      throw HttpException(
        message: 'errors.noMore'.tr(args: [targetAmountProduct.productName]),
      );
    }
  }

  //---------------------- Add Range amount from bill --------------------------
  Future<void> addRangeAmountToBill({String serialNumber}) async {
    loadedItems = [];
    await fetchCarProduct();
    // for(var item in loadedItems){}
    // int carIndex =
    //     loadedItems.indexWhere((item) => item.serialNumber == serialNumber);
    int billIndex =
        bill.indexWhere((item) => item.productId == targetProduct.productId);
    if (billIndex != -1 &&
        targetProduct != null &&
        targetProduct.quantity > bill[billIndex].quantity) {
      print(':::::::::::::' + range.toString());
      bill[billIndex].quantity = range.round();
      print(':::::::::::::' + bill[billIndex].quantity.toString());
      resetRange();
      returnTotal();
      notifyListeners();
    } else {
      throw HttpException(
        message: 'errors.noMore'.tr(args: [targetProduct.productName]),
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
    sum = sum;
//    print('::::::::::' + priceTaxesPlan.toString());
    if (priceTaxesPlan != null) {
      double temp =
          (sum * priceTaxesPlan.taxes[chosenTaxPlan].amount / 100) + sum;
      priceAfterTax = temp - sale;
    }
    sum = double.tryParse(sum.toStringAsFixed(2).toString());
    return sum;
  }

  //-------------------------- Total bill after tax ----------------------------
  void applySale({double value}) {
    sale = 0.0;
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
//   Future<void> payCash({int storeId, double total, String sale}) async {
//     await fetchUserData();
//     const url = 'https://api.hmto-eleader.com/api/sellsman/transaction/cache';
//     try {
//       var body = {
// //        "created_by": userId.toString(),
//         "business_id": businessId.toString(),
//         "location_id": locationId,
//         "contact_id": storeId.toString(),
//         "total_before_tax": (total - double.tryParse(sale)).toString(),
//         "final_total": priceAfterTax.toStringAsFixed(2).toString(),
//         "products": json.encode(bill),
//         "tax_id": priceTaxesPlan.taxes[chosenTaxPlan].id.toString(),
//         "tax_amount": (priceTaxesPlan.taxes[chosenTaxPlan].amount * total / 100)
//             .toString(),
//         "discount_amount": sale,
//       };
//
//       Map<String, String> headers = {
//         "Authorization": "Bearer $token",
//       };
// //      print('Request body : ' + body);
//       final response = await http.post(
//         url,
//         headers: headers,
//         body: body,
//       );
//       print("Response :" + response.body.toString());
//       final Map responseData = json.decode(response.body);
//       if (response.statusCode >= 200 && response.statusCode < 300) {
//         //remove items from car and balance the products
//         transactionId = responseData['transaction_id'].toString();
//         await finishBill();
//         notifyListeners();
//         return true;
//       } else {
//         throw HttpException(message: responseData['message']);
//       }
//     } catch (error) {
//       print('Request Error :' + error.toString());
//       throw error;
//     }
//   }

  Future<void> payCash(
      {int storeId, double total, String sale, File image}) async {
    await fetchUserData();
    const url = 'https://api.hmto-eleader.com/api/sellsman/transaction/cache';
    try {
      await prepareBillBeforeSending();
      var formData = FormData();
      formData.fields..add(MapEntry('created_by', userId.toString()));
      formData.fields..add(MapEntry('business_id', businessId.toString()));
      formData.fields..add(MapEntry('location_id', locationId));
      formData.fields..add(MapEntry('contact_id', storeId.toString()));
      formData.fields
        ..add(MapEntry(
            'total_before_tax', (total - double.tryParse(sale)).toString()));
      formData.fields
        ..add(MapEntry(
            'final_total', priceAfterTax.toStringAsFixed(2).toString()));
      formData.fields..add(MapEntry('products', json.encode(bill)));
      formData.fields
        ..add(MapEntry(
            'tax_id', priceTaxesPlan.taxes[chosenTaxPlan].id.toString()));
      formData.fields
        ..add(MapEntry(
            'tax_amount',
            (priceTaxesPlan.taxes[chosenTaxPlan].amount * total / 100)
                .toString()));
      formData.fields..add(MapEntry('discount_amount', sale));
      if (image != null)
        formData.files.add(MapEntry(
          'document',
          await MultipartFile.fromFile(image.path,
              filename: image.path.split("/").last),
        ));
      print(':::::::::::::::::::' + formData.files.toString());
      var response = await dio.post(
        url,
        data: formData,
        onSendProgress: (sent, total) {
          notifyListeners();
        },
        options: Options(
          headers: {
            // 'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          // validateStatus: (status) {
          //   return status == 500;
          // }
        ),
      );
      print("Response :" + response.toString());
      final Map responseData = json.decode(response.toString());
      transactionId = responseData['transaction_id'].toString();
      await finishBill();
      notifyListeners();
      return true;
    } catch (error) {
      print('Request Error :' + error.toString());
      if (!error.toString().contains('Unexpected character (at character 1)')) {
        throw error;
      }
      print('Request Error :' + error.toString());
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
      await prepareBillBeforeSending();
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
        "lat": latCache.toString(),
        "lan": lanCache.toString(),
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
      if (response.body.contains('400')) {
        throw HttpException(message: 'لا يمكنك استرجاع منتجات لهذا المتجر');
      } else if (response.statusCode >= 200 && response.statusCode < 300) {
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

  String getName({int id}) {
    String name =
        billProducts.firstWhere((item) => item.id == id).product ?? '';
    return name;
  }

  //------------------- Add product to returned invoice ------------------------
  Future<void> addItemToReturnedInvoice({String serialNumber}) async {
    loadedItems = [];
    await fetchCarProduct();
    CarProduct targetReturnedProduct;
    for (var carItem in loadedItems) {
      if (serialNumber == carItem.serialNumber) {
        targetReturnedProduct = CarProduct(
          productId: carItem.productId,
          serialNumber: carItem.serialNumber,
          productName: carItem.productName,
          quantity: 1,
          units: [],
          groupPrice: carItem.groupPrice,
        );
        break;
      } else {
        for (var unit in carItem.units) {
          if (serialNumber == unit.sku) {
            targetReturnedProduct = CarProduct(
              productId: unit.id,
              serialNumber: unit.sku,
              productName: unit.actualName,
              quantity: unit.unitCount,
              units: [],
              groupPrice: carItem.groupPrice,
            );
            break;
          }
        }
      }
    }
    // int index = loadedItems.indexWhere((i) => i.serialNumber == serialNumber);
    if (targetReturnedProduct != null) {
      int billIndex = returnedBill
          .indexWhere((i) => i.productId == targetReturnedProduct.productId);
      if (billIndex != -1) {
        throw HttpException(message: tr('errors.exist'));
      } else {
        int oldInvoiceIndex = billProducts
            .indexWhere((item) => item.id == targetReturnedProduct.productId);
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
    CarProduct targetReturnedProduct;
    for (var carItem in loadedItems) {
      if (serialNumber == carItem.serialNumber) {
        targetReturnedProduct = CarProduct(
          productId: carItem.productId,
          serialNumber: carItem.serialNumber,
          productName: carItem.productName,
          quantity: 1,
          units: [],
          groupPrice: carItem.groupPrice,
        );
        break;
      } else {
        for (var unit in carItem.units) {
          if (serialNumber == unit.sku) {
            targetReturnedProduct = CarProduct(
              productId: unit.id,
              serialNumber: unit.sku,
              productName: unit.actualName,
              quantity: unit.unitCount,
              units: [],
              groupPrice: carItem.groupPrice,
            );
            break;
          }
        }
      }
    }
    int billIndex = returnedBill.indexWhere(
        (item) => item.productId == targetReturnedProduct?.productId ?? -1);
    int oldInvoiceIndex = billProducts.indexWhere(
        (item) => item.id == targetReturnedProduct?.productId ?? -1);
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
    allRange = 0.0;
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
      // returnedBill = [];
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

  Future<double> returnTotalOwnMoney() async {
    final prefs = await SharedPreferences.getInstance();
    var money = prefs.getDouble('totalCarMoney');
    print('Money : ' + money.toString());
    await fetchCarProduct();
    double sum = 0;
    loadedItems.forEach((item) {
      sum = sum + (item.priceForEach * item.quantity);
    });
    print('Sum : ' + sum.toString());
    print('ALl : ' + (money - sum).toString());
//    print('Total price : ' + sum.toString());
    return money - sum;
  }

  //------------------------- Fetch debit invoices -----------------------------
  Future<void> fetchDebitInvoices({int storeId}) async {
    print(storeId);
    print(token);
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
  // Future<void> payOldDebitInvoice(
  //     {int transactionId, String amountPaid}) async {
  //   await fetchUserData();
  //   const url = 'https://api.hmto-eleader.com/api/sellsman/paid/debit';
  //   try {
  //     var body = {
  //       "transaction_id": transactionId.toString(),
  //       "amount_paid": amountPaid,
  //     };
  //     Map<String, String> headers = {
  //       'Authorization': 'Bearer $token',
  //     };
  //     final response = await http.post(
  //       url,
  //       headers: headers,
  //       body: body,
  //     );
  //     print("Response :" + response.body.toString());
  //     final responseData = json.decode(response.body);
  //     if (response.statusCode >= 200 && response.statusCode < 300) {
  //       notifyListeners();
  //       return true;
  //     } else {
  //       throw HttpException(message: responseData['error']);
  //     }
  //   } catch (error) {
  //     print('Request Error :' + error.toString());
  //     throw error;
  //   }
  // }

  Future<void> payOldDebitInvoice({
    int storeId,
    int transactionId,
    String amountPaid,
    File image,
    String type,
  }) async {
    await fetchUserData();
    const url = 'https://api.hmto-eleader.com/api/sellsman/paid/debit';
    try {
      var formData = FormData();
      formData.fields
        ..add(MapEntry('transaction_id', transactionId.toString()));
      formData.fields..add(MapEntry('amount_paid', amountPaid));
      if (image != null)
        formData.files.add(MapEntry(
          'img',
          await MultipartFile.fromFile(image.path,
              filename: image.path.split("/").last),
        ));
      formData.fields..add(MapEntry('type', type));
      var response = await dio.post(
        url,
        data: formData,
        onSendProgress: (sent, total) {
          notifyListeners();
        },
        options: Options(
          headers: {
            // 'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      await fetchDebitInvoices(storeId: storeId);
      print("Response :" + response.toString());
      notifyListeners();
      return true;
    } catch (error) {
      print('Request Error :' + error.toString());
      if (!error.toString().contains(
          'DioError [DioErrorType.DEFAULT]: FormatException: Unexpected character (at character 1)')) {
        throw error;
      }
      print('Request Error :' + error.toString());
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
  Future<void> donePlans() async {
    loadedItems = [];
    CarProduct targetProductPricePlan;
    await fetchCarProduct();
    int priceId = priceTaxesPlan.groupPrice[chosenPricePlan].id;
    for (var billItem in bill) {
      for (var carItem in loadedItems) {
        if (billItem.productId == carItem.productId) {
          targetProductPricePlan = CarProduct(
            productId: carItem.productId,
            serialNumber: carItem.serialNumber,
            productName: carItem.productName,
            quantity: 1,
            units: [],
            groupPrice: carItem.groupPrice,
          );
          break;
        } else {
          for (var unit in carItem.units) {
            if (billItem.productId == unit.id) {
              billItemRef.add(carItem);
              targetProductPricePlan = CarProduct(
                productId: unit.id,
                serialNumber: unit.sku,
                productName: unit.actualName,
                quantity: unit.unitCount,
                units: [],
                groupPrice: carItem.groupPrice,
              );
              break;
            }
          }
        }
      }
      print("::::::::::::" + targetProductPricePlan.toString());
      print('::::::::::::::' + targetProductPricePlan?.productName ?? 'null');

      if (targetProductPricePlan != null) {
        billItemRef.add(targetProductPricePlan);
        double groupPriceTemp = targetProductPricePlan.groupPrice
            .firstWhere((groupPrice) => groupPrice.id == priceId)
            .priceIncTax;
        print('GroupPrice : ' + groupPriceTemp.toString());
        print('Quantity : ' + targetProductPricePlan.quantity.toString());
        billItem.unitPrice = (targetProductPricePlan.quantity * groupPriceTemp);
        billItem.unitPriceBeforeDiscount = billItem.unitPrice;
        billItem.unitPriceIncTax = billItem.unitPrice;
      } else {
        throw HttpException(
            message: 'error adding new price ,could not find the right price');
      }
    }

    // bill.forEach((item) {
    //   int targetIndex = loadedItems
    //       .indexWhere((carItem) => item.productId == carItem.productId);
    //
    //   if (targetIndex != -1) {
    //     item.unitPrice = loadedItems[targetIndex]
    //         .groupPrice
    //         .firstWhere((groupPrice) => groupPrice.id == priceId)
    //         .priceIncTax;
    //     item.unitPriceBeforeDiscount = item.unitPrice;
    //     item.unitPriceIncTax = item.unitPrice;
    //   } else {
    //     throw HttpException(
    //         message: 'error adding new price ,could not find the right price');
    //   }
    // });
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
    billItemRef.clear();
    notifyListeners();
  }

  double totalReturnedBill() {
    double sum = 0;
    returnedBill.forEach((item) {
      sum = sum + (item.quantity);
    });
//    print('Total price : ' + sum.toString());
    return sum;
  }

  Future<void> prepareBillBeforeSending() async {
    List<BillProduct> refBill = [];
    BillProduct billRefProduct;
    for (var billItem in bill) {
      for (var carItem in loadedItems) {
        if (billItem.productId == carItem.productId) {
          billRefProduct = BillProduct(
            productId: billItem.productId,
            quantity: billItem.quantity,
            unitPrice: billItem.unitPrice,
            unitPriceBeforeDiscount: billItem.unitPriceBeforeDiscount,
            unitPriceIncTax: billItem.unitPriceIncTax,
          );
          break;
        } else {
          for (var unit in carItem.units) {
            if (billItem.productId == unit.id) {
              billRefProduct = BillProduct(
                productId: carItem.productId,
                quantity: (billItem.quantity * unit.unitCount),
                unitPrice: (billItem.unitPrice / unit.unitCount),
                unitPriceBeforeDiscount:
                    billItem.unitPriceBeforeDiscount / unit.unitCount,
                unitPriceIncTax: billItem.unitPriceIncTax / unit.unitCount,
              );
              break;
            }
          }
        }
      }
      if (billRefProduct != null) {
        refBill.add(billRefProduct);
        billRefProduct = null;
      }
    }
    bill = refBill;
    print('ShowUnits :::' + json.encode(bill));
  }

  Future<String> showUnits(CarProduct item, BuildContext context) async {
    var selectedUnit;
    if (item.units != null || item.units.isNotEmpty) {
      selectedUnit = await GlobalAlertDialog.showUnits(item, context);
    }
    print('ShowUnits :::' + selectedUnit.toString());
    return selectedUnit;
  }
}
