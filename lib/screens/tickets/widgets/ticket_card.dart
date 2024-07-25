import 'package:assignment/screens/tickets/widgets/ticket_detail_bottom_sheet.dart';
import 'package:flutter/material.dart';

class TicketListCardWidget extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final int tickets;
  final int ticketIndex;
  final String ticketType;
  final bool isScanned;
  final String ticketId;

  const TicketListCardWidget({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.tickets,
    required this.ticketIndex,
    required this.ticketType,
    required this.isScanned,
    required this.ticketId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showTicketDetail(context),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
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
                    name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    phoneNumber,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Image.asset(
                    "assets/images/ticket.png",
                    color: Colors.grey,
                    width: 30,
                    height: 30,
                  ),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Theme.of(context).colorScheme.background,
                    child: Text(
                      tickets.toString().padLeft(2, '0'),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTicketDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => TicketDetailBottomSheet(
        name: name,
        phonenumber: phoneNumber,
        tickets: tickets,
        ticketType: ticketType,
        isScanned: isScanned,
        ticketId: ticketId,
      ),
    );
  }
}
