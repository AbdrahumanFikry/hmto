import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:senior/models/httpExceptionModel.dart';
import 'package:senior/models/qrResult.dart';
import 'package:senior/models/startDaySalles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SellsData with ChangeNotifier {
  String token;
  int userId;
  String userName;
  int businessId;
  String date;

  StartDayData startDayData;
  QrResult qrResult;

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
        "user_id": '29',
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
      var body = json.encode({
        "qrcode": "$qrData",
        "user_id": "$userId",
      });

      Map<String, String> headers = {
//        'Content-Type': 'application/json',
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
}
