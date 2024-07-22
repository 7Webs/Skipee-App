class GetUserModel {
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
  WorksIn? worksIn;
  String? birthDate;

  GetUserModel(
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
      this.worksIn,
      this.birthDate});

  GetUserModel.fromJson(Map<String, dynamic> json) {
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
    worksIn =
        json['worksIn'] != null ? new WorksIn.fromJson(json['worksIn']) : null;
    birthDate = json['birthDate'];
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
    if (this.worksIn != null) {
      data['worksIn'] = this.worksIn!.toJson();
    }
    data['birthDate'] = this.birthDate;
    return data;
  }
}

class WorksIn {
  String? sId;
  String? name;
  String? email;
  String? phone;
  String? logo;
  String? owner;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? approved;

  WorksIn(
      {this.sId,
      this.name,
      this.email,
      this.phone,
      this.logo,
      this.owner,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.approved});

  WorksIn.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    logo = json['logo'];
    owner = json['owner'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    approved = json['approved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['logo'] = this.logo;
    data['owner'] = this.owner;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['approved'] = this.approved;
    return data;
  }
}
