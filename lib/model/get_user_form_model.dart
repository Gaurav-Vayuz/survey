class GetUserFormData {
  dynamic sId;
  dynamic name;
  dynamic contactNo;
  dynamic city;
  dynamic remarks;
  dynamic selectedEmoji;
  User? user;
  dynamic iV;

  GetUserFormData(
      {this.sId,
      this.name,
      this.contactNo,
      this.city,
      this.remarks,
      this.selectedEmoji,
      this.user,
      this.iV});

  GetUserFormData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    contactNo = json['contactNo'];
    city = json['city'];
    remarks = json['remarks'];
    selectedEmoji = json['selectedEmoji'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['contactNo'] = this.contactNo;
    data['city'] = this.city;
    data['remarks'] = this.remarks;
    data['selectedEmoji'] = this.selectedEmoji;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class User {
  dynamic sId;
  dynamic username;
  dynamic password;
  dynamic admin;
  List<String>? forms;
  int? iV;

  User(
      {this.sId,
      this.username,
      this.password,
      this.admin,
      this.forms,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    password = json['password'];
    admin = json['admin'];
    forms = json['forms'].cast<String>();
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['password'] = this.password;
    data['admin'] = this.admin;
    data['forms'] = this.forms;
    data['__v'] = this.iV;
    return data;
  }
}
