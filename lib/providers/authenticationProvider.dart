import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/httpExceptionModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  String type;
  int _userId;
  int _businessId;

  bool get isAuth {
    return _token != null;
  }

  String get token {
    return _token;
  }

  int get userId {
    return _userId;
  }

  int get businessId {
    return _businessId;
  }

  //-------------------------------- LogIn -------------------------------------
  Future<void> logIn({String email, String password}) async {
    const url = 'https://api.hmto-eleader.com/oauth/token';
    try {
      var body = {
        'username': email,
        'password': password,
        'grant_type': 'password',
        'client_id': '2',
        'client_secret': '83mW91iXZenucUT4paaGuDNnNL29OFp19EDN80CY',
      };

      final response = await http.post(
        url,
        body: body,
      );
      final Map responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('::::::::::::::::' + responseData.toString());
        _token = responseData['access_token'];
        _userId = responseData['user_id'];
        type = responseData['work_type'];
        _businessId = responseData['business_id'];
        print(
            'userID::::::$_userId\nBusinessId:::::$_businessId\nType:::::$type\nToken:::::$_token\n');
        final prefs = await SharedPreferences.getInstance();
        final userData = {
          'token': _token,
          'userId': _userId,
          'type': type,
          'businessId': _businessId,
        };
        prefs.setString('userData', json.encode(userData));
        notifyListeners();
        return true;
      } else {
        throw HttpException(message: responseData['error']);
      }
    } catch (error) {
      throw error;
    }
  }

  //------------------------------ AutoLogin -----------------------------------
  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    type = extractedUserData['type'];
    _businessId = extractedUserData['business_id'];
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    type = null;
    _businessId = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
