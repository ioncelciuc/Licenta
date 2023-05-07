import 'dart:convert';
import 'dart:developer';

import 'package:flutter_app/utils/dotenv_paths.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/network/response/response.dart';

class AuthHelper {
  static Future<Response> signIn(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(DotEnvPaths().signIn()),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "username": username,
          "password": password,
        }),
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return Response(success: true, obj: data);
      } else {
        return Response(
          success: false,
          message: "Sign in failed with status code ${response.statusCode}",
        );
      }
    } catch (e) {
      String message = "Error on sign in!";
      log(message, error: e);
      return Response(
        success: false,
        message: message,
      );
    }
  }

  static Future<Response> signUp(String username, String password) async {
    log('called sign up');
    try {
      final response = await http.post(
        Uri.parse(DotEnvPaths().signUp()),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "username": username,
          "password": password,
        }),
      );
      if (response.statusCode == 409) {
        log('username already taken');
        Map<String, dynamic> serverResponse = jsonDecode(response.body);
        String usernameTakenMessage = serverResponse['message'];
        log(usernameTakenMessage);
        return Response(
          success: false,
          message: usernameTakenMessage,
        );
      } else if (response.statusCode >= 200 && response.statusCode <= 299) {
        log('sign up successfull');
        Map<String, dynamic> data = jsonDecode(response.body);
        return Response(success: true, obj: data);
      } else {
        log('unknown error occured');
        return Response(
          success: false,
          message: "Sign up failed with status code ${response.statusCode}",
        );
      }
    } catch (e) {
      String message = "Error on sign up!";
      log(message, error: e);
      return Response(
        success: false,
        message: message,
      );
    }
  }
}
