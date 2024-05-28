import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String date;
  final String time;
  final String description;
  final String location;
  final String imageUrl;

  const EventCard({
    super.key,
    required this.date,
    required this.time,
    required this.description,
    required this.location,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Image.asset(
            imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: Color(0xFF1eb953), // Changed green to #1eb953
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                textAlign: TextAlign.center,
                "${date.split(' ')[0]}\n${date.split(' ')[1].toUpperCase()}",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Positioned(
            top: 16,
            right: 16,
            child: Icon(
              Icons.bookmark_border,
              color: Colors.white,
            ),
          ),
          Positioned(
            top: 25,
            left: 75,
            child: Text(
              time,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 35),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        color: Color(0xFF1eb953)), // Changed green to #1eb953
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Color(0xFF1eb953)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
