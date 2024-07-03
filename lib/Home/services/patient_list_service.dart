 import 'dart:developer';
import 'dart:io';

import 'package:doctor_consulting_app/Home/models/patient_list_model.dart';
 import 'dart:convert';

 import 'package:flutter/cupertino.dart';
 import 'package:http/http.dart' as http;
 import 'package:http/http.dart';
 import 'package:provider/provider.dart';

 class PatientListService {
   static Future<PatientListModel?> getPatientList(String token
       ) async {
     Map<String, String> headers = {
       "Content-Type": "application/json",
       HttpHeaders.authorizationHeader: "Bearer $token"
     };
     const String apiUrl = 'https://flutter-amr.noviindus.in/api/PatientList';
     try {
       Response response = await http.get(Uri.parse(apiUrl),headers: headers);
       final jsonResponse = json.decode(response.body);
       log("patient list data-----$jsonResponse");
       return PatientListModel.fromJson(jsonResponse);
     } on Exception catch (e) {
       debugPrint(e.toString());
       return null;
     }
   }

 }