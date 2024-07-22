import 'dart:convert';

import 'package:assignment/common/constants.dart';
import 'package:assignment/models/get_events_model.dart';
import 'package:http/http.dart' as http;

class EventsRepo {
  Future<List<GetEventsModel>> getEvents() async {
    final url = Uri.parse("$URL/sites/events");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => GetEventsModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load events");
    }
  }
}
