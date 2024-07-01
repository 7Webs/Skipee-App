import 'package:assignment/features/tickets/ui/screens/ticket_list_screen.dart';
import 'package:flutter/material.dart';

class TicketRadioBottomSheet extends StatefulWidget {
  const TicketRadioBottomSheet({
    super.key,
  });

  @override
  State<TicketRadioBottomSheet> createState() => _TicketRadioBottomSheetState();
}

class _TicketRadioBottomSheetState extends State<TicketRadioBottomSheet> {
  String _selectedTicketType = 'Queue Skips';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Transform.scale(
                    scale: 2,
                    child: Radio<String>(
                      value: 'Queue Skips',
                      groupValue: _selectedTicketType,
                      fillColor: MaterialStatePropertyAll(
                          _selectedTicketType == 'Queue Skips'
                              ? const Color(0xFF1eb953)
                              : Colors.grey),
                      onChanged: (value) {
                        setState(() {
                          _selectedTicketType = value!;
                        });
                      },
                    ),
                  ),
                  const Text(
                    'Queue Skips',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ],
              ),
              Column(
                children: [
                  Transform.scale(
                    scale: 2,
                    child: Radio<String>(
                      value: 'Entry Tickets',
                      fillColor: MaterialStatePropertyAll(
                          _selectedTicketType == 'Entry Tickets'
                              ? const Color(0xFF1eb953)
                              : Colors.grey),
                      groupValue: _selectedTicketType,
                      onChanged: (value) {
                        setState(() {
                          _selectedTicketType = value!;
                        });
                      },
                    ),
                  ),
                  const Text(
                    'Entry Tickets',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => TicketListScreen(
                              isTickets: _selectedTicketType == 'Entry Tickets',
                            )));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1eb953),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rectangle shape
                ),
              ),
              child: const Text(
                'GO',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
