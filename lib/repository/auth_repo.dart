import 'dart:convert';
import 'dart:developer';
import 'package:assignment/common/constants.dart';
import 'package:assignment/models/get_user_model.dart';
import 'package:assignment/models/login_user_model.dart';
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
    final url = Uri.parse("$URL/auth/register");
    final response = await http.post(url, body: request);
    if (response.statusCode == 201) {
      log("registered Successfully");
      return true;
    } else {
      throw Exception("Failed to register");
    }
  }

  Future<LoginUserModel> loginUser(String email, String password) async {
    Map<String, dynamic> request = {"email": email, "password": password};
    final url = Uri.parse("$URL/auth/login");
    final response = await http.post(url, body: request);
    final data = jsonDecode(response.body);
    if (response.statusCode == 201) {
      log("logged in successfully");
      return LoginUserModel.fromJson(data);
    } else {
      log("${data["message"]} $password");
      throw Exception("${data["message"]}");
    }
  }

  Future<GetUserModel> getUser(String token) async {
    final url = Uri.parse("$URL/auth");
    final response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      log("logged in successfully");
      return GetUserModel.fromJson(data);
    } else {
      log(data.toString());
      throw Exception("Failed to login");
    }
  }

  Future<GetUserModel> updateUser(String name, String password, String token,
      String gender, String birthDate, String email) async {
    final url = Uri.parse("$URL/users");
    Map<String, dynamic> request = {
      "name": name,
      "email": email,
      "password": password,
      "isActive": "true",
      "gender": gender,
      "birthDate": birthDate
    };
    final response = await http.patch(url,
        headers: {"Authorization": "Bearer $token"}, body: request);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      log("Details Changed Successfully");
      return GetUserModel.fromJson(data);
    } else {
      log(data.toString());
      throw Exception("Failed to Update Details");
    }
  }
}
