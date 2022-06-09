


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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactsInfoResponse &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          message == other.message &&
          contact == other.contact &&
          error == other.error &&
          errorMsg == other.errorMsg;

  @override
  int get hashCode =>
      status.hashCode ^
      message.hashCode ^
      contact.hashCode ^
      error.hashCode ^
      errorMsg.hashCode;

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

  Contact({this.id, this.name, this.phone, this.destination});

  Contact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    destination = json['destination'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['destination'] = this.destination;
    return data;
  }
}

