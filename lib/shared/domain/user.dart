class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? contacts;
  String? statistics;
  String? authorization;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
        this.contacts,
        this.statistics,
      this.authorization});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    contacts = json['contacts'];
    statistics = json['statistics'];
    authorization = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['contacts'] = this.contacts;
    data['statistics'] = this.statistics;
    data['token'] = this.authorization;
    return data;
  }
}
