import 'dart:convert';

import 'package:assignment/features/events/model/events.dart';
import 'package:http/http.dart' as http;

class EventsRepo {
  Future<List<Events>> getEvents() async {
    final url =
        Uri.parse("https://squid-app-xxu6w.ondigitalocean.app/sites/events");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Events.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load events");
    }
  }
}
