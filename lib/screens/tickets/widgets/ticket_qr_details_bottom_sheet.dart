import 'package:assignment/models/get_events_model.dart';
import 'package:assignment/models/get_ticket_model.dart';
import 'package:assignment/screens/tickets/ticket_approval_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TicketQrDetailsBottomSheet extends StatelessWidget {
  const TicketQrDetailsBottomSheet(
      {super.key, required this.ticket, required this.event});
  final GetTicketModel ticket;
  final GetEventsModel event;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
            image: NetworkImage(event.image!), fit: BoxFit.cover, opacity: 0.3),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/calendar.png',
                    width: 30,
                    height: 30,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('d MMMM yyyy')
                          .format(DateTime.parse(event.date.toString())),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${DateFormat('EEEE').format(DateTime.parse(event.date.toString()))}, ${event.startTime} - ${event.endTime}',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (event.tickets != null)
              for (final eventTicket in event.tickets!)
                if (eventTicket.sId == ticket.sId)
                  Center(
                    child: Text(
                      eventTicket.name!,
                      style: theme.textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
            const SizedBox(height: 10),
            if (ticket.name != null)
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Name : ',
                      style: theme.textTheme.headlineSmall!
                          .copyWith(color: Colors.white),
                    ),
                    TextSpan(
                        text: ticket.name,
                        style: theme.textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            const SizedBox(height: 5),
            if (ticket.email != null)
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Email : ',
                      style: theme.textTheme.headlineSmall!
                          .copyWith(color: Colors.white),
                    ),
                    TextSpan(
                        text: ticket.email,
                        style: theme.textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            if (ticket.site != null)
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Site : ',
                      style: theme.textTheme.headlineSmall!
                          .copyWith(color: Colors.white),
                    ),
                    TextSpan(
                        text: ticket.site,
                        style: theme.textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            if (ticket.noOfUser != null)
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Number of People : ',
                      style: theme.textTheme.headlineSmall!
                          .copyWith(color: Colors.white),
                    ),
                    TextSpan(
                        text: ticket.noOfUser.toString(),
                        style: theme.textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ],
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
                      borderRadius: BorderRadius.circular(10),
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
            )
          ],
        ),
      ),
    );
  }
}
