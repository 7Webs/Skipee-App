import 'dart:convert';
import 'dart:developer';

import 'package:assignment/common/constants.dart';
import 'package:assignment/models/get_ticket_model.dart';
import 'package:http/http.dart' as http;

class TicketRepo {
  Future<bool> scanTicket(String id) async {
    final url = Uri.parse("$URL/tickets/$id");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      log("Successfully Fetched Ticket");
      final data = jsonDecode(response.body);
      final ticketData = GetTicketModel.fromJson(data);
      if (!ticketData.isScaned!) {
        final url = Uri.parse("$URL/tickets/approve/$id");
        final response = await http.get(url);
        if (response.statusCode == 200) {
          log("Ticked Succesfully Scanned");
          return true;
        } else {
          log("Ticket Scanning Failed");
        }
      } else {
        log("Ticket is scanned already");
      }
    } else {
      log("Ticket Fetching Failed");
    }
    return false;
  }
}
