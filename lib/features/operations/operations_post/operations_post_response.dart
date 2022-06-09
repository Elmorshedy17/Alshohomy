
import 'package:shahowmy_app/shared/domain/user.dart';

class OperationsPostResponse {
  int? status;
  String? message;

  var error;
  String? errorMsg;

  OperationsPostResponse.makeError({this.error, this.errorMsg});
  OperationsPostResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  OperationsPostResponse({this.status, this.message,});

  OperationsPostResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

}
