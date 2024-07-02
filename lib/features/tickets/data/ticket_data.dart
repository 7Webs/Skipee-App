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
      imageUrl:
          'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg',
      name: 'Dinesh Sharma',
      username: 'dineshsharma785',
      tickets: 10,
    ),
    TicketData(
      imageUrl:
          'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg',
      name: 'Holly',
      username: 'holly654354',
      tickets: 4,
    ),
    TicketData(
      imageUrl:
          'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg',
      name: 'Henry',
      username: 'Henry25121326',
      tickets: 5,
    ),
    TicketData(
      imageUrl:
          'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg',
      name: 'Imogen',
      username: 'Imogen9878',
      tickets: 8,
    ),
    TicketData(
      imageUrl:
          'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg',
      name: 'Thomas',
      username: 'thomas66936',
      tickets: 10,
    ),
    TicketData(
      imageUrl:
          'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg',
      name: 'Jacqueline',
      username: 'Jacqueline6545454',
      tickets: 12,
    ),
    TicketData(
      imageUrl:
          'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg',
      name: 'Katherine',
      username: 'Katherine65965',
      tickets: 15,
    ),
  ];
}
