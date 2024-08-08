import 'dart:async';
import 'package:assignment/common/widgets/event_appbar.dart';
import 'package:assignment/models/get_ticket_model.dart';
import 'package:assignment/models/get_ticket_user_model.dart';
import 'package:assignment/repository/ticket_repo.dart';
import 'package:assignment/screens/tickets/widgets/ticket_data.dart';
import 'package:assignment/models/get_events_model.dart';
import 'package:assignment/screens/tickets/widgets/ticket_card.dart';
import 'package:flutter/material.dart';

class TicketListScreen extends StatefulWidget {
  const TicketListScreen(
      {super.key, required this.ticketIndex, required this.event});
  final int ticketIndex;
  final GetEventsModel event;

  @override
  State<TicketListScreen> createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  bool isLoading = false;
  List<GetTicketUserModel> userList = [];

  @override
  void initState() {
    getUserList();
    super.initState();
  }

  void getUserList() async {
    setState(() {
      isLoading = true;
    });
    userList = await TicketRepo()
        .getTicketUser(widget.event.tickets![widget.ticketIndex].sId!);

    setState(() {
      isLoading = false;
    });
  }

  void _refreshScreen() {
    setState(() {
      isLoading = true;
    });

    // Simulate a network request or other asynchronous operation
    Timer(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ticketType = widget.event.tickets![widget.ticketIndex].name ?? "";
    final totalTicketQuantity =
        widget.event.tickets![widget.ticketIndex].totalQuantity ?? "";
    final ticketId = widget.event.tickets![widget.ticketIndex].sId ?? "";
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                EventAppbar(
                  event: widget.event,
                  onPressed: _refreshScreen,
                  haveSearch: true,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ticketType,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      // Row(
                      //   children: [
                      //     Image.asset(
                      //       "assets/images/ticket.png",
                      //       color: Colors.black,
                      //       width: 30,
                      //       height: 30,
                      //     ),
                      //     Text(
                      //       totalTicketQuantity,
                      //       style: Theme.of(context).textTheme.titleLarge,
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      final user = userList[index];
                      if (user.eventTicket!.sId == ticketId) {
                        return TicketListCardWidget(
                          name: user.name!,
                          phoneNumber: user.phone!,
                          tickets: user.noOfUser!,
                          enteredTickets: user.entered!,
                          ticketIndex: widget.ticketIndex,
                          ticketType: ticketType,
                          isScanned: user.isScaned!,
                          ticketId: user.sId!,
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
