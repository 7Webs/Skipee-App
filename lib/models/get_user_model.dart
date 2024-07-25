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
      this.worksIn});

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
  bool? approved;
  String? createdAt;
  String? updatedAt;
  int? iV;

  WorksIn(
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

  WorksIn.fromJson(Map<String, dynamic> json) {
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
