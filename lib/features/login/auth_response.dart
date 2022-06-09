
import 'package:shahowmy_app/shared/domain/user.dart';

class AuthResponse {
  int? status;
  String? message;
  User? user;

  var error;
  String? errorMsg;

  AuthResponse.makeError({this.error, this.errorMsg});
  AuthResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  AuthResponse({this.status, this.message, this.user});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['data'] != null ? new User.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['data'] = this.user!.toJson();
    }
    return data;
  }
}
