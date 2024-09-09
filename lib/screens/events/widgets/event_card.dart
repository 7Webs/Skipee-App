import 'package:assignment/common/constants.dart';
import 'package:assignment/providers/saved_events_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventCard extends ConsumerWidget {
  final String date;
  final String startTime;
  final String endTime;
  final String description;
  final String location;
  final String imageUrl;
  final String id;

  const EventCard({
    super.key,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.location,
    required this.imageUrl,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedEvents = ref.watch(savedEventsProvider);
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.30,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            opacity: 0.5,
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1eb953),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          date.isNotEmpty
                              ? "${date.split(' ')[0]}\n${date.split(' ')[1].toUpperCase()}"
                              : "",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '$startTime - $endTime',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: savedEvents.contains(id)
                        ? const Icon(Icons.bookmark)
                        : const Icon(Icons.bookmark_border),
                    color: Colors.white,
                    onPressed: () {
                      !savedEvents.contains(id)
                          ? showSnackBar(context, "Event Added to WishList",
                              Colors.green.shade400)
                          : showSnackBar(context, "Event Removed from WishList",
                              Colors.green.shade400);
                      ref
                          .read(savedEventsProvider.notifier)
                          .toggleSavedEvents(id);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  Text(
                    description,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Color(0xFF1eb953)),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: Theme.of(context).textTheme.bodyMedium!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
