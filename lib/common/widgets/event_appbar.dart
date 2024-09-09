import 'package:assignment/models/get_events_model.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class EventAppbar extends StatelessWidget {
  const EventAppbar({
    super.key,
    required this.event,
    required this.onPressed,
    required this.haveSearch,
  });
  final GetEventsModel event;
  final VoidCallback onPressed;
  final bool haveSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.black,
        image: event.image != null
            ? DecorationImage(
                image: NetworkImage(event.image!),
                fit: BoxFit.cover,
                opacity: 0.5,
                onError: (exception, stackTrace) => Container(),
              )
            : null,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      constraints: BoxConstraints(
        //maxHeight: haveSearch ? 290 : 230,
        maxHeight: 230,
        maxWidth: MediaQuery.of(context).size.width,
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              IconButton(
                iconSize: 24,
                icon: const Icon(Icons.refresh, color: Colors.white),
                onPressed: onPressed,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (event.description != null)
                  Text(
                    event.description!,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                const SizedBox(height: 16),
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
                        if (event.date != null)
                          Text(
                            DateFormat('d MMMM yyyy')
                                .format(DateTime.parse(event.date.toString())),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          ),
                        if (event.date != null &&
                            event.startTime != null &&
                            event.endTime != null)
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
                // if (haveSearch)
                //   Container(
                //     padding: const EdgeInsets.symmetric(horizontal: 16),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(24),
                //     ),
                //     child: const Row(
                //       children: [
                //         Icon(FontAwesomeIcons.magnifyingGlass,
                //             color: Color(0xFF1eb953)),
                //         SizedBox(width: 8),
                //         Expanded(
                //           child: TextField(
                //             decoration: InputDecoration(
                //               hintStyle: TextStyle(color: Colors.grey),
                //               hintText: 'Search...',
                //               border: InputBorder.none,
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
