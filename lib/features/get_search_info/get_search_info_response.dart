
class SearchInfoResponse {
  int? status;
  String? message;
  Data? data;
  var error;
  String? errorMsg;

  SearchInfoResponse.makeError({this.error, this.errorMsg});
  SearchInfoResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }
  SearchInfoResponse({this.status, this.message, this.data});

  SearchInfoResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Destination>? statusValues;
  List<Destination>? destination;

  Data({this.statusValues, this.destination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['status_values'] != null) {
      statusValues = <Destination>[];
      json['status_values'].forEach((v) {
        statusValues!.add(new Destination.fromJson(v));
      });
    }
    if (json['destination'] != null) {
      destination = <Destination>[];
      json['destination'].forEach((v) {
        destination!.add(new Destination.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.statusValues != null) {
      data['status_values'] =
          this.statusValues!.map((v) => v.toJson()).toList();
    }
    if (this.destination != null) {
      data['destination'] = this.destination!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Destination {
  dynamic id;
  String? name;

  Destination({this.id, this.name});

  Destination.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

