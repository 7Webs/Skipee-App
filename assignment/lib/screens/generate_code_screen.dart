import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:item_count_number_button/item_count_number_button.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import 'package:assignment/models/user_model.dart';
import 'package:assignment/screens/scan_code_screen.dart';
import 'package:assignment/services/ticket_services.dart';

class GenerateCodeScreen extends StatefulWidget {
  final UserModel user;
  const GenerateCodeScreen({super.key, required this.user});

  @override
  State<GenerateCodeScreen> createState() => _GenerateCodeScreenState();
}

class _GenerateCodeScreenState extends State<GenerateCodeScreen> {
  String? qrData;
  String noOfUsers = "0";

  void generateQrCode() async {
    String name = widget.user.user!.name!;
    String email = widget.user.user!.email!;
    try {
      String id = await TicketServices().generateTicket(name, email, noOfUsers);
      qrData = id;
      setState(() {});
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate QR Code'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScanCodeScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.qr_code_scanner,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, ${widget.user.user!.name}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              const Text(
                "Add number of Users",
                style: TextStyle(fontSize: 16),
              ),
              ItemCount(
                color: Colors.grey,
                buttonSizeHeight: 40,
                textStyle: const TextStyle(fontSize: 16),
                buttonSizeWidth: 40,
                initialValue: int.parse(noOfUsers),
                minValue: 0,
                maxValue: 10,
                decimalPlaces: 0,
                onChanged: (value) {
                  setState(() {
                    noOfUsers = value.toString();
                  });
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  onPressed: () {
                    generateQrCode();
                  },
                  child: const Text(
                    "Generate Ticket Qr Code",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              if (qrData != null)
                Center(
                  child: SizedBox(
                    height: 250,
                    width: 250,
                    child: PrettyQrView.data(data: qrData!),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
