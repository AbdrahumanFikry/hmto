import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:senior/models/agentsModel.dart';
import 'package:senior/models/fieldForceSeniorTargetModel.dart';
import 'package:http/http.dart'as http;

class SeniorFieldForceData with ChangeNotifier{
  FieldForceSeniorTargetModel fieldForceSeniorTargetModel;
  AgentsModel agentsModel;

  //----------------------Fetch Target Senior------------------------------
  Future<void> fetchTargetSenior() async {
    const url = 'https://api.hmto-eleader.com/api/seniorFieldForce/analysis';
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        fieldForceSeniorTargetModel = FieldForceSeniorTargetModel.fromJson(responseData);
        notifyListeners();
        return fieldForceSeniorTargetModel;
      }
    } catch (error) {
      throw error;
    }
  }
  //-------------------------Fetch Agents------------------------------------------
  Future<void> fetchAgents() async {
    const url = 'https://api.hmto-eleader.com/api/seniorFieldForce';
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        agentsModel = AgentsModel.fromJson(responseData);
        notifyListeners();
        return agentsModel;
      }
    } catch (error) {
      throw error;
    }
  }
}