class Events {
  Events({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.site,
    required this.lastEntryTime,
    required this.minAgeLimit,
    required this.tickets,
    required this.owner,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? name;
  final String? description;
  final String? image;
  final DateTime? date;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? location;
  final Site? site;
  final DateTime? lastEntryTime;
  final int? minAgeLimit;
  final List<dynamic> tickets;
  final Owner? owner;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Events.fromJson(Map<String, dynamic> json) {
    return Events(
      id: json["_id"],
      name: json["name"],
      description: json["description"],
      image: json["image"],
      date: DateTime.tryParse(json["date"] ?? ""),
      startTime: DateTime.tryParse(json["startTime"] ?? ""),
      endTime: DateTime.tryParse(json["endTime"] ?? ""),
      location: json["location"],
      site: json["site"] == null ? null : Site.fromJson(json["site"]),
      lastEntryTime: DateTime.tryParse(json["lastEntryTime"] ?? ""),
      minAgeLimit: json["minAgeLimit"],
      tickets: json["tickets"] == null
          ? []
          : List<dynamic>.from(json["tickets"]!.map((x) => x)),
      owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
      status: json["status"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "image": image,
        "date": date?.toIso8601String(),
        "startTime": startTime?.toIso8601String(),
        "endTime": endTime?.toIso8601String(),
        "location": location,
        "site": site?.toJson(),
        "lastEntryTime": lastEntryTime?.toIso8601String(),
        "minAgeLimit": minAgeLimit,
        "tickets": tickets.map((x) => x).toList(),
        "owner": owner?.toJson(),
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Owner {
  Owner({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.isActive,
    required this.lastSeen,
    required this.gender,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.worksIn,
    required this.birthDate,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? role;
  final bool? isActive;
  final DateTime? lastSeen;
  final String? gender;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? worksIn;
  final DateTime? birthDate;

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
      password: json["password"],
      role: json["role"],
      isActive: json["isActive"],
      lastSeen: DateTime.tryParse(json["lastSeen"] ?? ""),
      gender: json["gender"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      worksIn: json["worksIn"],
      birthDate: DateTime.tryParse(json["birthDate"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "password": password,
        "role": role,
        "isActive": isActive,
        "lastSeen": lastSeen?.toIso8601String(),
        "gender": gender,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "worksIn": worksIn,
        "birthDate": birthDate?.toIso8601String(),
      };
}

class Site {
  Site({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.logo,
    required this.owner,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.approved,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? logo;
  final String? owner;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final bool? approved;

  factory Site.fromJson(Map<String, dynamic> json) {
    return Site(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      logo: json["logo"],
      owner: json["owner"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      approved: json["approved"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "logo": logo,
        "owner": owner,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "approved": approved,
      };
}
