class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? contacts;
  String? authorization;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
        this.contacts,
      this.authorization});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    contacts = json['contacts'];
    authorization = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['contacts'] = this.contacts;
    data['token'] = this.authorization;
    return data;
  }
}
