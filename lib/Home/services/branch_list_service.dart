import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import '../models/branch_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class BranchListService {

  static Future<BranchListModel?> fetchBranchList(String token) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    const String apiUrl = 'https://flutter-amr.noviindus.in/api/BranchList';
    try {
      Response response = await http.get(Uri.parse(apiUrl),headers: headers);
      final jsonResponse = json.decode(response.body);
      log("branch list data $jsonResponse");
      return BranchListModel.fromJson(jsonResponse);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}