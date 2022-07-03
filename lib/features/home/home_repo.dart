import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shahowmy_app/app_core/app_core.dart';
import 'package:shahowmy_app/app_core/networking/api_provider.dart';
import 'package:shahowmy_app/features/home/home_response.dart';

class HomeRepo {
  static Future<HomeResponse> home({required pageNum,String? status,String? destinationId,String? id,String? name,fromId}) async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            '${locator<ApiService>().dioClient.options.baseUrl}home_screen?status=$status&page=$pageNum&destination_id=$destinationId&name=$name&id=$id&from=$fromId',
          );

      return HomeResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return HomeResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return HomeResponse.makeError(
            error: error,
            errorMsg: 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription =  'حدث خطأ ما حاول مرة أخرى لاحقاً';

        return HomeResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }
}
