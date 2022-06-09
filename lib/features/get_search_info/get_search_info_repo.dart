import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shahowmy_app/app_core/app_core.dart';
import 'package:shahowmy_app/features/get_search_info/get_search_info_response.dart';

class SearchInfoRepo {
  static Future<SearchInfoResponse> getSearchInfo() async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            '${locator<ApiService>().dioClient.options.baseUrl}search_info',
          );

      return SearchInfoResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return SearchInfoResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return SearchInfoResponse.makeError(
            error: error, errorMsg: locator<PrefsService>().appLanguage == 'en'
            ? 'No Internet Connection'
            : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = locator<PrefsService>().appLanguage == 'en'
            ? 'Something Went Wrong Try Again Later'
            : 'حدث خطأ ما حاول مرة أخرى لاحقاً';

        return SearchInfoResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }
}
