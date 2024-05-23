import 'package:flutter/material.dart';

class ListTicketsScreen extends StatefulWidget {
  const ListTicketsScreen({super.key});

  @override
  State<ListTicketsScreen> createState() => _ListTicketsScreenState();
}

class _ListTicketsScreenState extends State<ListTicketsScreen> {
  final List<Map<String, dynamic>> tickets = List.generate(
    15,
    (index) => {
      'name': 'Ticket ${index + 1}',
      'icon': Icons.event,
      'quantity': (index + 1) * 5,
    },
  );

  String filter = 'ALL';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remaining Tickets', style: TextStyle(color: Colors.white)),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: filter,
              onChanged: (String? newValue) {
                setState(() {
                  filter = newValue!;
                });
              },
              items: <String>['ALL', 'USED', 'UNUSED']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: Colors.white)),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search here',
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                border: const OutlineInputBorder(),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: tickets.length,
              separatorBuilder: (context, index) => const Divider(color: Colors.white),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(tickets[index]['name'], style: TextStyle(color: Colors.white)),
                  trailing: Text('Quantity: ${tickets[index]['quantity']}', style: TextStyle(color: Colors.white)),
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
      ),
    );
  }
}
