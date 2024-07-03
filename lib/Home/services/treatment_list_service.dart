import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:doctor_consulting_app/Home/models/treatment_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class TreatmentListService {
  static Future<TreatmentListModel?> fetchTreatmentList(String token) async{
    Map<String, String> headers = {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    const String apiUrl = 'https://flutter-amr.noviindus.in/api/TreatmentList';
    try {
      Response response = await http.get(Uri.parse(apiUrl),headers: headers);
      final jsonResponse = json.decode(response.body);
      log("treatment list data $jsonResponse");
      return TreatmentListModel.fromJson(jsonResponse);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }

  }
}