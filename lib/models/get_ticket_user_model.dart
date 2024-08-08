class GetTicketUserModel {
  String? sId;
  int? entered;
  String? name;
  String? phone;
  int? amount;
  EventTicket? eventTicket;
  int? noOfUser;
  bool? isScaned;
  bool? isConfirmed;
  String? createdAt;
  String? updatedAt;
  int? iV;

  GetTicketUserModel(
      {this.sId,
      this.name,
      this.entered,
      this.phone,
      this.amount,
      this.eventTicket,
      this.noOfUser,
      this.isScaned,
      this.isConfirmed,
      this.createdAt,
      this.updatedAt,
      this.iV});

  GetTicketUserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    entered = json['entered'];
    phone = json['phone'];
    amount = json['amount'];
    eventTicket = json['eventTicket'] != null
        ? new EventTicket.fromJson(json['eventTicket'])
        : null;
    noOfUser = json['noOfUser'];
    isScaned = json['isScaned'];
    isConfirmed = json['isConfirmed'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['entered'] = this.entered;
    data['phone'] = this.phone;
    data['amount'] = this.amount;
    if (this.eventTicket != null) {
      data['eventTicket'] = this.eventTicket!.toJson();
    }
    data['noOfUser'] = this.noOfUser;
    data['isScaned'] = this.isScaned;
    data['isConfirmed'] = this.isConfirmed;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class EventTicket {
  String? sId;
  String? name;
  String? totalQuantity;
  String? availableQuantity;
  String? price;
  String? type;
  Event? event;
  Site? site;
  String? saleStartTime;
  String? saleEndTime;
  int? iV;
  String? createdAt;
  String? updatedAt;

  EventTicket(
      {this.sId,
      this.name,
      this.totalQuantity,
      this.availableQuantity,
      this.price,
      this.type,
      this.event,
      this.site,
      this.saleStartTime,
      this.saleEndTime,
      this.iV,
      this.createdAt,
      this.updatedAt});

  EventTicket.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    totalQuantity = json['totalQuantity'];
    availableQuantity = json['availableQuantity'];
    price = json['price'];
    type = json['type'];
    event = json['event'] != null ? new Event.fromJson(json['event']) : null;
    site = json['site'] != null ? new Site.fromJson(json['site']) : null;
    saleStartTime = json['saleStartTime'];
    saleEndTime = json['saleEndTime'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['totalQuantity'] = this.totalQuantity;
    data['availableQuantity'] = this.availableQuantity;
    data['price'] = this.price;
    data['type'] = this.type;
    if (this.event != null) {
      data['event'] = this.event!.toJson();
    }
    if (this.site != null) {
      data['site'] = this.site!.toJson();
    }
    data['saleStartTime'] = this.saleStartTime;
    data['saleEndTime'] = this.saleEndTime;
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Event {
  String? sId;
  String? name;
  String? description;
  String? image;
  String? date;
  String? startTime;
  String? endTime;
  String? location;
  String? site;
  String? lastEntryTime;
  int? minAgeLimit;
  List<String>? tickets;
  String? owner;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Event(
      {this.sId,
      this.name,
      this.description,
      this.image,
      this.date,
      this.startTime,
      this.endTime,
      this.location,
      this.site,
      this.lastEntryTime,
      this.minAgeLimit,
      this.tickets,
      this.owner,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Event.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    location = json['location'];
    site = json['site'];
    lastEntryTime = json['lastEntryTime'];
    minAgeLimit = json['minAgeLimit'];
    tickets = json['tickets'].cast<String>();
    owner = json['owner'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['date'] = this.date;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['location'] = this.location;
    data['site'] = this.site;
    data['lastEntryTime'] = this.lastEntryTime;
    data['minAgeLimit'] = this.minAgeLimit;
    data['tickets'] = this.tickets;
    data['owner'] = this.owner;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Site {
  String? sId;
  String? name;
  String? email;
  String? phone;
  String? logo;
  String? owner;
  bool? approved;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Site(
      {this.sId,
      this.name,
      this.email,
      this.phone,
      this.logo,
      this.owner,
      this.approved,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Site.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    logo = json['logo'];
    owner = json['owner'];
    approved = json['approved'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['logo'] = this.logo;
    data['owner'] = this.owner;
    data['approved'] = this.approved;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
