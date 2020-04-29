import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:senior/models/httpExceptionModel.dart';
import 'package:senior/models/qrResult.dart';
import 'package:senior/models/startDaySalles.dart';
import 'package:senior/models/stores.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SellsData with ChangeNotifier {
  String token;
  int userId;
  String userName;
  int businessId;
  String date;

  StartDayData startDayData;
  QrResult qrResult;
  Stores stores;
  List<CarProduct> bill = [];

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
        final prefs = await SharedPreferences.getInstance();
        if (!prefs.containsKey('cartItems')) {
          final userData = json.encode(
            {
              'data': startDayData.productsInOwnCar,
            },
          );
          prefs.setString('cartItems', userData);
        }
        if (!prefs.containsKey('locationId')) {
          final userData = json.encode(
            {
              'data': startDayData.locationId,
            },
          );
          prefs.setString('locationId', userData);
        }
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
  void addItemToBill({String serialNumber}) {
    List<CarProduct> loadedItems = fetchCarProduct();
    int index = loadedItems.indexWhere((i) => i.serialNumber == serialNumber);
    if (index != -1) {
      throw HttpException(message: 'product not fount in the car');
    } else {
      bill.add(
        CarProduct(
          productId: loadedItems[index].productId,
          productName: loadedItems[index].productName,
          quantity: 1,
          priceForEach: loadedItems[index].priceForEach,
          serialNumber: loadedItems[index].serialNumber,
        ),
      );
    }
    returnTotal();
    notifyListeners();
  }

  //--------------------- Fetch data from SharedPreferences --------------------
  fetchCarProduct() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('cartItems')) {
      return null;
    }
    final responseData =
        json.decode(prefs.getString('cartItems')) as Map<String, dynamic>;
    final List<CarProduct> loadedItems = [];
    responseData['data'].forEach((itemData) {
      loadedItems.add(CarProduct(
        productId: itemData['product_id'],
        productName: itemData['product_name'],
        serialNumber: itemData['Sku'],
        quantity: itemData['quantity'],
        priceForEach: itemData['default_sell_price'],
      ));
    });
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
  void addAmountFromBill({int id}) {
    List<CarProduct> loadedItems = fetchCarProduct();
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
          message: 'No more ${bill[billIndex].productName} in the car');
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
      sum = sum + (item.priceForEach * item.quantity);
    });
    notifyListeners();
    return sum;
  }

  //---------------------------- Balance car products---------------------------
  Future<void> finishBill() async {
    try {
      final List<CarProduct> loadedItems = fetchCarProduct();
      bill.forEach((item) {
        loadedItems.removeWhere(
          (product) => product.productId == item.productId,
        );
      });
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('cartItems')) {
        final userData = json.encode(
          {
            'data': loadedItems,
          },
        );
        prefs.setString('cartItems', userData);
      }
      notifyListeners();
    } catch (error) {
      throw HttpException(message: 'Could not balance products');
    }
  }
}
