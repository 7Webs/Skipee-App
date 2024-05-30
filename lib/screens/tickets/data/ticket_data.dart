class TicketData {
  final String imageUrl;
  final String name;
  final String username;
  final int tickets;

  TicketData({
    required this.imageUrl,
    required this.name,
    required this.username,
    required this.tickets,
  });
  static List<TicketData> dummyData = [
    TicketData(
      imageUrl: 'assets/images/event1.png',
      name: 'Dinesh Sharma',
      username: 'dineshsharma785',
      tickets: 10,
    ),
    TicketData(
      imageUrl: 'assets/images/event2.png',
      name: 'Holly',
      username: 'holly654354',
      tickets: 4,
    ),
    TicketData(
      imageUrl: 'assets/images/event3.png',
      name: 'Henry',
      username: 'Henry25121326',
      tickets: 5,
    ),
    TicketData(
      imageUrl: 'assets/images/event1.png',
      name: 'Imogen',
      username: 'Imogen9878',
      tickets: 8,
    ),
    TicketData(
      imageUrl: 'assets/images/event2.png',
      name: 'Thomas',
      username: 'thomas66936',
      tickets: 10,
    ),
    TicketData(
      imageUrl: 'assets/images/event3.png',
      name: 'Jacqueline',
      username: 'Jacqueline6545454',
      tickets: 12,
    ),
    TicketData(
      imageUrl: 'assets/images/event1.png',
      name: 'Katherine',
      username: 'Katherine65965',
      tickets: 15,
    ),
  ];
}
