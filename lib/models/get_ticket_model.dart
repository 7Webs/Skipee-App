class GetTicketModel {
  bool? isConfirmed;
  String? sId;
  String? name;
  String? email;
  String? site;
  int? noOfUser;
  bool? isScaned;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  int? iV;

  GetTicketModel(
      {this.isConfirmed,
      this.sId,
      this.name,
      this.email,
      this.site,
      this.noOfUser,
      this.isScaned,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.iV});

  GetTicketModel.fromJson(Map<String, dynamic> json) {
    isConfirmed = json['isConfirmed'];
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    site = json['site'];
    noOfUser = json['noOfUser'];
    isScaned = json['isScaned'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isConfirmed'] = this.isConfirmed;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['site'] = this.site;
    data['noOfUser'] = this.noOfUser;
    data['isScaned'] = this.isScaned;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
