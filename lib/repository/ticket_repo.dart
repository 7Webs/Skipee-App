import 'dart:convert';
import 'dart:developer';

import 'package:assignment/common/constants.dart';
import 'package:assignment/models/get_ticket_model.dart';
import 'package:assignment/models/get_ticket_user_model.dart';
import 'package:http/http.dart' as http;

class TicketRepo {
  Future<GetTicketModel> scanTicket(String id) async {
    final url = Uri.parse("$URL/tickets/$id");

    final response = await http.get(url);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      log("Successfully Fetched Ticket");

      return GetTicketModel.fromJson(data);
    } else {
      log(data.toString());
      throw Exception("Ticket Not Found");
    }
  }
  Future<GetTicketModel> approveTicket(String id) async {
    final url = Uri.parse("$URL/tickets/approve/$id");

    final response = await http.get(url);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      log("Successfully Fetched Ticket");

      return GetTicketModel.fromJson(data);
    } else {
      log(data.toString());
      throw Exception("Ticket Not Found");
    }
  }

  Future<List<GetTicketUserModel>> getTicketUser(String id) async {
    final url = Uri.parse("$URL/tickets/tickets-type/$id");
    List<GetTicketUserModel> list = [];

    final response = await http.get(url);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      log(response.toString());
      for (var user in data) {
        list.add(GetTicketUserModel.fromJson(user));
      }
      return list;
    } else {
      log(data.toString());
      throw Exception("Ticket User Not Found");
    }
  }
}
