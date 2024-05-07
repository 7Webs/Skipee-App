import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class TicketServices {
  Future<String> generateTicket(
    String name,
    String email,
    String noOfUsers,
  ) async {
    Map<String, dynamic> request = {
      "name": name,
      "email": email,
      "site": "66142c86d368b9e789ec874f",
      "noOfUser": noOfUsers,
      "isScaned": "false",
      "isActive": "true"
    };
    final url = Uri.parse("https://squid-app-xxu6w.ondigitalocean.app/tickets");
    final response = await http.post(url, body: request);
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      log(data['_id'].toString());
      return data['_id'];
    } else {
      log("error in fetching id");
      return "error";
    }
  }

  Future<bool> getTicket(String id) async {
    final url =
        Uri.parse("https://squid-app-xxu6w.ondigitalocean.app/tickets/$id");
    try {
      final response = await http.get(url);
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        log("Successfully Scanned");
        return true;
      } else if (response.statusCode == 409) {
        log("Already Used Ticket");
        return false;
      }
    } catch (e) {
      log("error");
    }

    return false;
  }
}
