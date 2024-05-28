import 'package:assignment/screens/tickets/widgets/ticket_detail_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TicketListCardWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String username;
  final int tickets;
  final bool isTicket;

  const TicketListCardWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.username,
    required this.tickets,
    required this.isTicket,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showTicketDetail(context),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(imageUrl),
                radius: 30,
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    username,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  Icon(
                      size: 20,
                      isTicket ? FontAwesomeIcons.ticket : Icons.flash_on,
                      color: Colors.grey),
                  SizedBox(width: 4),
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
        imageUrl: imageUrl,
        name: name,
        username: username,
        tickets: tickets,
      ),
    );
  }
}
