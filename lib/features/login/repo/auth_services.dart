import 'dart:convert';
import 'dart:developer';

import 'package:assignment/features/login/models/user_data_model.dart';
import 'package:assignment/features/login/models/user_model.dart';
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
    final data = jsonDecode(response.body);
    if (response.statusCode == 201) {
      log("logged in successfully");
      return UserModel.fromJson(data);
    } else {
      log("${data["message"]} $password");
      throw Exception("${data["message"]}");
    }
  }

  Future<UserData> getUser(String token) async {
    final url = Uri.parse("https://squid-app-xxu6w.ondigitalocean.app/auth");
    final response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      log("logged in successfully");
      return UserData.fromJson(data);
    } else {
      log(data.toString());
      throw Exception("Failed to login");
    }
  }
}
