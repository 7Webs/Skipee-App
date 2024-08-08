import 'dart:developer';

import 'package:assignment/common/constants.dart';
import 'package:http/http.dart' as http;

class ReportRepo {
  Future<bool> postReport(
      String reportedBy,
      String incidentDate,
      String description,
      String site,
      String investigationNotes,
      String token) async {
    Map<String, dynamic> request = {
      "reportedBy": reportedBy,
      "incidentDate": incidentDate,
      "description": description,
      "site": site,
      "investigationNotes": incidentDate,
    };
    final url = Uri.parse("$URL/reports");
    final response = await http
        .post(url, body: request, headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 201) {
      log("Reported Successfully");
      return true;
    } else {
      log(response.body.toString());
      return false;
    }
  }
}
