import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/httpExceptionModel.dart';
import '../models/questions.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class FieldForceData with ChangeNotifier {
  String token;
  int userId;
  String userName;
  int businessId;
  String progress = '0';

  var dio = Dio();
  QuestionsList questionsList;
  List<Question> trueAndFalse;
  List<Question> longAnswerQuestion;

  //--------------------------- Fetch questions --------------------------------
  Future<void> fetchQuestions() async {
    const url = 'https://api.hmto-eleader.com/api/questions';
    try {
      await fetchUserData();
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });
      final Map responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('::::::::::::::::' + responseData.toString());
        questionsList = QuestionsList.fromJson(responseData);
        trueAndFalse = questionsList.questions
            .where((i) => i.type == 'falseOrTrue')
            .toList();
        longAnswerQuestion = questionsList.questions
            .where((i) => i.type != 'falseOrTrue')
            .toList();
        return true;
      } else {
        throw HttpException(message: responseData['error']);
      }
    } catch (error) {
      throw error;
    }
  }

  //----------------------------- Add new shop ---------------------------------
  Future<void> addNewShop({
    String shopName,
    String customerName,
    String customerPhone,
    String sellsName,
    String sellsPhone,
    double rate,
    String lat,
    String long,
    File image1,
    File image2,
    File image3,
    File image4,
    String landmark,
    String position,
    String answers,
  }) async {
    await fetchUserData();
    const url = 'https://api.hmto-eleader.com/api/add_field_force_shop';
    try {
      print('::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: '
          '\n$shopName\n$customerName\n$customerPhone\n$sellsName\n$sellsPhone\n'
          '$rate\n$answers\n$lat\n$long\n$landmark\n$position\n$businessId\n$userId\n$image1\n$image2\n$image3\n$image4');
      var formData = FormData();
      formData.fields..add(MapEntry('business_id', businessId.toString()));
      formData.fields..add(MapEntry('supplier_business_name', shopName));
      formData.fields..add(MapEntry('name', customerName));
      formData.fields..add(MapEntry('mobile', customerPhone));
      formData.fields..add(MapEntry('alternate_name', sellsName));
      formData.fields..add(MapEntry('alternate_number', sellsPhone));
      formData.fields..add(MapEntry('lat', lat));
      formData.fields..add(MapEntry('long', long));
      formData.fields..add(MapEntry('rate', rate.toString()));
      if (image1 != null)
        formData.files.add(MapEntry(
          'image_in',
          await MultipartFile.fromFile(image1.path,
              filename: image1.path.split("/").last),
        ));
      if (image2 != null)
        formData.files.add(MapEntry(
          'image_out',
          await MultipartFile.fromFile(image1.path,
              filename: image2.path.split("/").last),
        ));
      if (image3 != null)
        formData.files.add(MapEntry(
          'image_storeAds',
          await MultipartFile.fromFile(image1.path,
              filename: image3.path.split("/").last),
        ));
      if (image4 != null)
        formData.files.add(MapEntry(
          'image_storeFront',
          await MultipartFile.fromFile(image1.path,
              filename: image4.path.split("/").last),
        ));
      formData.fields..add(MapEntry('landmark', landmark));
      formData.fields..add(MapEntry('position', position));
      formData.fields..add(MapEntry('created_by', userId.toString()));
      formData.fields..add(MapEntry('questionsAnswer', answers));
      var response = await dio.post(
        url,
        data: formData,
        onSendProgress: (sent, total) {
          progress = (sent / total * 100).toStringAsFixed(0);
          print(progress);
          notifyListeners();
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
//            followRedirects: false,
//            validateStatus: (status) {
//              return status == 500;
//            },
        ),
      );
      print(':::::::::::::::' + response.toString());
      notifyListeners();
      return true;
    } catch (error) {
      if (!error.toString().contains(
          'DioError [DioErrorType.DEFAULT]: FormatException: Unexpected character (at character 1)')) {
        throw error;
      }
      print(error.toString());
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

  //------------------------------ Qr reader -----------------------------------
  Future<void> qrReader({String qrData}) async {
    const url = 'https://api.hmto-eleader.com/api/store/visited';
    try {
      final response = await http.post(url, body: {
        "qrcode": "$qrData",
        "user_id": "$userId",
      });
      final Map responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('::::::::::::::::' + responseData.toString());
        return true;
      } else {
        throw HttpException(message: responseData['error']);
      }
    } catch (error) {
      throw error;
    }
  }
}
