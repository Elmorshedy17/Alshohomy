import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shahowmy_app/app_core/locator.dart';
import 'package:shahowmy_app/app_core/app_core.dart';
import 'package:shahowmy_app/app_core/fcm/FcmTokenManager.dart';

class CustomInterceptor implements Interceptor {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers = {
      'FirebaseToken': locator<FcmTokenManager>().currentFcmToken,
      'Platform': Platform.isAndroid ? 'android' : 'ios',
      'Lang': locator<PrefsService>().appLanguage,
      'Auth': locator<PrefsService>().userObj?.authorization ?? '',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    return handler.next(options);
  }

  @override
  Future onResponse(Response response, handler) async {
    switch (response.statusCode) {
      case 200:
        // print(response);
        return handler.next(response);
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.data.toString());
      case 500:
      default:
        throw FetchDataException(
            '''Error occurred while Communication with Server with StatusCode :
             ${response.statusCode}''');
    }
  }

  @override
  Future onError(DioError e, handler) async {
    return handler.next(e);
  }
}
