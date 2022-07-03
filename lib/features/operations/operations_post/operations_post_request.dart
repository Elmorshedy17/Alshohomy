class OperationsPostRequest {
  String? status;
  String? transfer;
  String? notes;

  OperationsPostRequest({this.status, this.transfer,this.notes});

  OperationsPostRequest.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    transfer = json['transfer'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['transfer'] = transfer;
    data['notes'] = notes;
    return data;
  }
}

