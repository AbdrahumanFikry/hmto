import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/httpExceptionModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  String type;

  bool get isAuth {
    return _token != null;
  }

  String get token {
    return _token;
  }

  //-------------------------------- LogIn -------------------------------------
  Future<void> logIn({String email, String password}) async {
    const url = 'https://hmto-eleader.com/oauth/token';
    try {
      var body = {
        'username': email,
        'password': password,
        'grant_type': 'password',
        'client_id': '2',
        'client_secret': '6ZxyqIBbKfQNKvLnlhdOE2IhO9CeUnemty5Es6bf',
      };

      final response = await http.post(
        url,
        body: body,
      );
      final Map responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('::::::::::::::::' + responseData.toString());
        _token = responseData['access_token'];
        final prefs = await SharedPreferences.getInstance();
        final userData = {
          'token': _token,
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
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
