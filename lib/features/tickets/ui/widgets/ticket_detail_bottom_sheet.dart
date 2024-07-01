import 'package:assignment/features/events/ui/screens/ticket_approval_screen.dart';
import 'package:flutter/material.dart';

class TicketDetailBottomSheet extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String username;
  final int tickets;

  const TicketDetailBottomSheet({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.username,
    required this.tickets,
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
                  backgroundImage: AssetImage(widget.imageUrl),
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
                      widget.username,
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
                            color: negativeButtonColor,
                          ),
                          onPressed: selectedTickets > 1
                              ? () {
                                  setState(() {
                                    selectedTickets--;
                                  });
                                }
                              : null,
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
                            color: positiveButtonColor,
                          ),
                          onPressed: selectedTickets < widget.tickets
                              ? () {
                                  setState(() {
                                    selectedTickets++;
                                  });
                                }
                              : null,
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ticket Type:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  DropdownButton<String>(
                    value: selectedTicketType,
                    items: <String>['General Admission', 'VIP', 'Backstage']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTicketType = newValue!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const TicketApprovalScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1eb953),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rectangle shape
                  ),
                ),
                child: Text(
                  'ADMIT',
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
