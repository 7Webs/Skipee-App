import 'dart:convert';
import 'dart:developer';

import 'package:assignment/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  Future<bool> registerUser(String name, String email, String password) async {
    Map<String, dynamic> request = {
      "name": name,
      "email": email,
      "password": password,
      "role": "user",
      "isActive": "true"
    };
    final url =
        Uri.parse("https://squid-app-xxu6w.ondigitalocean.app/auth/register");
    final response = await http.post(url, body: request);
    if (response.statusCode == 201) {
      log("registered Successfully");
      return true;
    } else {
      throw Exception("Failed to register");
    }
  }

  Future<UserModel> loginUser(String email, String password) async {
    Map<String, dynamic> request = {"email": email, "password": password};
    final url =
        Uri.parse("https://squid-app-xxu6w.ondigitalocean.app/auth/login");
    final response = await http.post(url, body: request);
    if (response.statusCode == 201) {
      log("logged in successfully");
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      log("DID NOT LOGIN");
      throw Exception("Failed to login");
    }
  }
}
