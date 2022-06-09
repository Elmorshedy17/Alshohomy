
class OperationsInfoResponse {
  int? status;
  String? message;
  Data? data;

  var error;
  String? errorMsg;

  OperationsInfoResponse.makeError({this.error, this.errorMsg});
  OperationsInfoResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  OperationsInfoResponse({this.status, this.message, this.data});

  OperationsInfoResponse.fromJson(Map<String, dynamic> json) {
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
  String? id;
  List<ChoicesStatus>? choicesStatus;
  List<ChoicesStatus>? choicesTransfer;

  Data({this.id, this.choicesStatus, this.choicesTransfer});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['choices_status'] != null) {
      choicesStatus = <ChoicesStatus>[];
      json['choices_status'].forEach((v) {
        choicesStatus!.add(new ChoicesStatus.fromJson(v));
      });
    }
    if (json['choices_transfer'] != null) {
      choicesTransfer = <ChoicesStatus>[];
      json['choices_transfer'].forEach((v) {
        choicesTransfer!.add(new ChoicesStatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.choicesStatus != null) {
      data['choices_status'] =
          this.choicesStatus!.map((v) => v.toJson()).toList();
    }
    if (this.choicesTransfer != null) {
      data['choices_transfer'] =
          this.choicesTransfer!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChoicesStatus {
  String? id;
  String? name;
  String? active;

  ChoicesStatus({this.id, this.name, this.active});

  ChoicesStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['active'] = this.active;
    return data;
  }
}

