class GetEventsModel {
  String? sId;
  String? name;
  String? description;
  String? image;
  String? date;
  String? startTime;
  String? endTime;
  String? location;
  Site? site;
  String? lastEntryTime;
  int? minAgeLimit;
  List<Tickets>? tickets;
  Owner? owner;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  GetEventsModel(
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

  GetEventsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    location = json['location'];
    site = json['site'] != null ? new Site.fromJson(json['site']) : null;
    lastEntryTime = json['lastEntryTime'];
    minAgeLimit = json['minAgeLimit'];
    if (json['tickets'] != null) {
      tickets = <Tickets>[];
      json['tickets'].forEach((v) {
        tickets!.add(new Tickets.fromJson(v));
      });
    }
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
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
    if (this.site != null) {
      data['site'] = this.site!.toJson();
    }
    data['lastEntryTime'] = this.lastEntryTime;
    data['minAgeLimit'] = this.minAgeLimit;
    if (this.tickets != null) {
      data['tickets'] = this.tickets!.map((v) => v.toJson()).toList();
    }
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
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

class Tickets {
  String? sId;
  String? name;
  String? totalQuantity;
  String? availableQuantity;
  String? price;
  String? type;
  String? event;
  String? site;
  String? saleStartTime;
  String? saleEndTime;
  int? iV;
  String? createdAt;
  String? updatedAt;

  Tickets(
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

  Tickets.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    totalQuantity = json['totalQuantity'];
    availableQuantity = json['availableQuantity'];
    price = json['price'];
    type = json['type'];
    event = json['event'];
    site = json['site'];
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
    data['event'] = this.event;
    data['site'] = this.site;
    data['saleStartTime'] = this.saleStartTime;
    data['saleEndTime'] = this.saleEndTime;
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Owner {
  String? sId;
  String? name;
  String? email;
  String? password;
  String? role;
  bool? isActive;
  String? lastSeen;
  String? gender;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? worksIn;

  Owner(
      {this.sId,
      this.name,
      this.email,
      this.password,
      this.role,
      this.isActive,
      this.lastSeen,
      this.gender,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.worksIn});

  Owner.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    isActive = json['isActive'];
    lastSeen = json['lastSeen'];
    gender = json['gender'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    worksIn = json['worksIn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['role'] = this.role;
    data['isActive'] = this.isActive;
    data['lastSeen'] = this.lastSeen;
    data['gender'] = this.gender;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['worksIn'] = this.worksIn;
    return data;
  }
}
