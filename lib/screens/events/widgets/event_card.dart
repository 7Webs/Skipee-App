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
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          color: Color(0xFF1eb953),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "${date.split(' ')[0]}\n${date.split(' ')[1].toUpperCase()}",
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
                        time,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.bookmark_border,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [],
              ),
              SizedBox(height: 16),
              Text(
                description,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on, color: Color(0xFF1eb953)),
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
      ),
    );
  }
}
