import 'dart:io';
import 'package:shahowmy_app/app_core/app_core.dart';
import 'package:dio/dio.dart';
import 'package:shahowmy_app/features/login/auth_response.dart';
import 'package:shahowmy_app/features/login/login_request.dart';

class LoginRepo {
  final prefs = locator<PrefsService>();

  Future<AuthResponse> login(LoginRequest request) async {
    FormData formData = FormData.fromMap(request.toJson());
    print(formData.fields);
    try {
      final Response response = await locator<ApiService>().dioClient.post(
            '${locator<ApiService>().dioClient.options.baseUrl}login',
            data: formData,
          );
      return AuthResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return AuthResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return AuthResponse.makeError(
            error: error,
            errorMsg: prefs.appLanguage == 'en'
                ? 'No Internet Connection'
                : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = prefs.appLanguage == 'en'
            ? "Unexpected error occurred"
            : 'حدث خظأ غير متوقع';

        return AuthResponse.makeError(error: error, errorMsg: errorDescription);
      }
    }
  }

}
