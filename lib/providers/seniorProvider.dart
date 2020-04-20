import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:senior/models/agentsModel.dart';
import 'package:senior/models/fieldForceSeniorTargetModel.dart';
import 'package:http/http.dart' as http;
import '../models/httpExceptionModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SeniorData with ChangeNotifier {
  String token;
  int userId;
  String userName;
  int businessId;

  FieldForceSeniorTargetModel fieldForceSeniorTarget;
  AgentsModel agents;

  //------------------------- Fetch senior target ------------------------------
  Future<void> fetchTargetSenior() async {
    const url = 'https://api.hmto-eleader.com/api/seniorFieldForce/analysis';
    await fetchUserData();
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      print("Response :" + response.body.toString());
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        fieldForceSeniorTarget =
            FieldForceSeniorTargetModel.fromJson(responseData);
        notifyListeners();
        return true;
      } else {
        throw HttpException(message: responseData['error']);
      }
    } catch (error) {
      throw error;
    }
  }

  //---------------------------- Fetch Agents ----------------------------------
  Future<void> fetchAgents() async {
    const url = 'https://api.hmto-eleader.com/api/seniorFieldForce';
    await fetchUserData();
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      print("Response :" + response.body.toString());
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        agents = AgentsModel.fromJson(responseData);
        notifyListeners();
        return true;
      } else {
        throw HttpException(message: responseData['error']);
      }
    } catch (error) {
      throw error;
    }
  }

  //----------------------------- Fetch Data -----------------------------------
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
}
