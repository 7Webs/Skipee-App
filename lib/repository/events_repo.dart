import 'dart:convert';

import 'package:assignment/common/constants.dart';
import 'package:assignment/models/get_events_model.dart';
import 'package:assignment/models/get_user_model.dart';
import 'package:assignment/repository/auth_repo.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EventsRepo {
  Future<List<GetEventsModel>> getEvents() async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token")!;
    final GetUserModel userData = await AuthServices().getUser(token);
    final url = Uri.parse("$URL/sites/events?siteId=${userData.worksIn!.sId}");
    // final url = Uri.parse("$URL/sites/events?siteId=");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => GetEventsModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load events");
    }
  }
}
