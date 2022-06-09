class OperationsPostRequest {
  String? status;
  String? transfer;

  OperationsPostRequest({this.status, this.transfer});

  OperationsPostRequest.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    transfer = json['transfer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['transfer'] = transfer;
    return data;
  }
}

