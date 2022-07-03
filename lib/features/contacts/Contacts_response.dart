


class ContactsInfoResponse {
  int? status;
  String? message;
  List<Contact>? contact;
  var error;
  String? errorMsg;

  ContactsInfoResponse.makeError({this.error, this.errorMsg});
  ContactsInfoResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }
  ContactsInfoResponse({this.status, this.message, this.contact});

  ContactsInfoResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      contact = <Contact>[];
      json['data'].forEach((v) {
        contact!.add(new Contact.fromJson(v));
      });
    }
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.contact != null) {
      data['data'] = this.contact!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contact {
  int? id;
  String? name;
  String? phone;
  String? destination;
  String? notes;

  Contact({this.id, this.name, this.phone, this.destination,this.notes});

  Contact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    destination = json['destination'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['destination'] = this.destination;
    data['notes'] = this.notes;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contact &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          phone == other.phone &&
          destination == other.destination &&
          notes == other.notes;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      phone.hashCode ^
      destination.hashCode ^
      notes.hashCode;
}

