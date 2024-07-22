import 'package:assignment/models/get_events_model.dart';
import 'package:assignment/providers/saved_events_provider.dart';
import 'package:assignment/repository/events_repo.dart';
import 'package:assignment/screens/events/events_screen.dart';
import 'package:assignment/screens/events/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class SavedEventsScreen extends ConsumerStatefulWidget {
  const SavedEventsScreen({super.key});
  @override
  ConsumerState<SavedEventsScreen> createState() => _SavedEventsScreenState();
}

class _SavedEventsScreenState extends ConsumerState<SavedEventsScreen> {
  bool _isLoading = false;
  List<GetEventsModel> events = [];
  @override
  void initState() {
    _getEvents();
    super.initState();
  }

  void _getEvents() async {
    setState(() {
      _isLoading = true;
    });
    events = await EventsRepo().getEvents();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final savedEvents = ref.watch(savedEventsProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1eb953),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Saved Events"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : savedEvents.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      
                      "assets/images/no_save.png",
                      color: const Color(0xFF1eb953),
                    ),
                    const Text(
                      "No Saved Events",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => EventsScreen(
                                event: events[index],
                              ),
                            ),
                          );
                        },
                        child: savedEvents.contains(events[index].id)
                            ? EventCard(
                                date: DateFormat('dd MMMM').format(
                                    DateTime.parse(
                                        events[index].date.toString())),
                                time: DateFormat('h:mm a').format(
                                    DateTime.parse(
                                        events[index].startTime.toString())),
                                description: events[index].description!,
                                location: events[index].location!,
                                imageUrl: events[index].image!,
                                id: events[index].id!,
                              )
                            : Container(),
                      );
                    },
                  ),
                ),
    );
  }
}
