import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../models/login_model.dart';
import 'package:http/http.dart' as http;
class LoginService {
  static Future<LoginModel?> userLogged(LoginRequestModel loginRequestModel
      ) async {
    const String apiUrl = 'https://flutter-amr.noviindus.in/api/Login';

    // Create the form data
    Map<String, String> formData = {
      'username': loginRequestModel.username.toString(),
      'password': loginRequestModel.password.toString(),
    };

    // Make the POST request
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: formData,
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Parse the response body
        final responseBody = json.decode(response.body);
        print('Response: $responseBody');
        return LoginModel.fromJson(responseBody);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}