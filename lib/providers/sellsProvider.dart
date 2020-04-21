import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:senior/models/httpExceptionModel.dart';
import 'package:senior/models/startDaySalles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SallesData with ChangeNotifier {
  String token;
  int userId;
  String userName;
  int businessId;

  SeniorStartDayModel seniorStartDayModel;

  //-------------------------- Fetch Data--------------------------------------
  Future<bool> fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
    json.decode(prefs.getString('userData')) as Map<String, Object>;
    token = extractedUserData['token'];
    print(token + "\n:::::::");
    userId = extractedUserData['userId'];
    businessId = extractedUserData['businessId'];
    userName = extractedUserData['userName'];
    notifyListeners();
    return true;
  }
  //--------------------------Fetch Start Day Data-----------------------------
  Future<void> fetchStartDayData() async {
    const url = 'https://api.hmto-eleader.com/api/sellsman/account';
    await fetchUserData();
    try {
      var body = {
        "user_id":userId
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
        seniorStartDayModel = SeniorStartDayModel.fromJson(responseData);
        notifyListeners();
        return true;
      } else {
        throw HttpException(message: responseData['error']);
      }
    } catch (error) {
      throw error;
    }
  }

}
