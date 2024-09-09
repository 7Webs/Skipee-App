import 'package:flutter/material.dart';

class TotalUsersBottomSheet extends StatefulWidget {
  final int totalUsers;

  const TotalUsersBottomSheet({super.key, required this.totalUsers});

  @override
  State<TotalUsersBottomSheet> createState() => _TotalUsersBottomSheetState();
}

class _TotalUsersBottomSheetState extends State<TotalUsersBottomSheet> {
  int selectedUsers = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Total Available Tickets: ${widget.totalUsers}",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.remove_circle_outline,
                  size: 40,
                  color: selectedUsers <= 1 ? Colors.grey : Colors.red,
                ),
                onPressed: selectedUsers <= 1
                    ? null
                    : () {
                        setState(() {
                          selectedUsers--;
                        });
                      },
              ),
              Container(
                width: 80,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: const Color(0xFF1eb953)),
                ),
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    selectedUsers.toString().padLeft(2, '0'),
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  size: 40,
                  Icons.add_circle_outline,
                  color: selectedUsers >= widget.totalUsers
                      ? Colors.grey
                      : Colors.green,
                ),
                onPressed: selectedUsers >= widget.totalUsers
                    ? null
                    : () {
                        setState(() {
                          selectedUsers++;
                        });
                      },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, selectedUsers); // Return selectedUsers
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1eb953),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rectangle shape
                  ),
                ),
                child: Text(
                  'SUBMIT',
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
