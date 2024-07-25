import 'package:assignment/models/get_ticket_model.dart';
import 'package:assignment/repository/ticket_repo.dart';
import 'package:assignment/screens/tickets/ticket_approval_screen.dart';
import 'package:flutter/material.dart';

class TicketDetailBottomSheet extends StatefulWidget {
  final String name;
  final String phonenumber;
  final int tickets;
  final String ticketType;
  final bool isScanned;
  final String ticketId;

  const TicketDetailBottomSheet({
    super.key,
    required this.name,
    required this.phonenumber,
    required this.tickets,
    required this.ticketType,
    required this.isScanned,
    required this.ticketId,
  });

  @override
  State<TicketDetailBottomSheet> createState() =>
      _TicketDetailBottomSheetState();
}

class _TicketDetailBottomSheetState extends State<TicketDetailBottomSheet> {
  int selectedTickets = 1;
  String selectedTicketType = 'General Admission';

  @override
  Widget build(BuildContext context) {
    Color negativeButtonColor =
        selectedTickets <= 1 ? Colors.grey : const Color(0xFF1eb953);
    Color positiveButtonColor = selectedTickets < widget.tickets
        ? const Color(0xFF1eb953)
        : Colors.grey;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 35,
                  ),
                  radius: 30,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      widget.phonenumber,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Tickets Available: ',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.tickets.toString().padLeft(2, '0'),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.remove_circle_outline,
                            color: widget.isScanned
                                ? Colors.grey
                                : negativeButtonColor,
                          ),
                          onPressed: widget.isScanned || selectedTickets <= 1
                              ? null
                              : () {
                                  setState(() {
                                    selectedTickets--;
                                  });
                                },
                        ),
                        Container(
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: const Color(0xFF1eb953)),
                          ),
                          child: Text(
                            textAlign: TextAlign.center,
                            selectedTickets.toString().padLeft(2, '0'),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: widget.isScanned
                                ? Colors.grey
                                : positiveButtonColor,
                          ),
                          onPressed: widget.isScanned ||
                                  selectedTickets >= widget.tickets
                              ? null
                              : () {
                                  setState(() {
                                    selectedTickets++;
                                  });
                                },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey.shade200,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ticket Type:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(widget.ticketType,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.isScanned
                    ? null
                    : () async {
                        GetTicketModel ticket =
                            await TicketRepo().approveTicket(widget.ticketId);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const TicketApprovalScreen(),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      widget.isScanned ? Colors.grey : const Color(0xFF1eb953),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rectangle shape
                  ),
                ),
                child: Text(
                  widget.isScanned ? 'Already Scanned' : 'ADMIT',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
