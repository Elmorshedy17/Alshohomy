class Operations {
  int? id;
  String? destination;
  String? name;
  String? phone;
  String? status;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Operations &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          destination == other.destination &&
          name == other.name &&
          phone == other.phone &&
          status == other.status &&
          link == other.link;

  @override
  int get hashCode =>
      id.hashCode ^
      destination.hashCode ^
      name.hashCode ^
      phone.hashCode ^
      status.hashCode ^
      link.hashCode;
  String? link;

  Operations({this.id, this.destination, this.name, this.phone, this.status,this.link});

  Operations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    destination = json['destination'];
    name = json['name'];
    phone = json['phone'];
    status = json['status'];
    link = json['link'];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['destination'] = this.destination;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['link'] = this.link;
    return data;
  }
}