import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shahowmy_app/app_core/app_core.dart';
import 'package:shahowmy_app/features/get_search_info/get_search_info_response.dart';
import 'package:shahowmy_app/features/operation_files/files_operations_info_response.dart';
import 'package:shahowmy_app/features/operations/operations_info/get_operations_info_response.dart';

class OperationFilesRepo {
  static Future<OperationFilesResponse> getOperationFiles({required operationId}) async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            '${locator<ApiService>().dioClient.options.baseUrl}operation_files/$operationId',
          );

      return OperationFilesResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return OperationFilesResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return OperationFilesResponse.makeError(
            error: error, errorMsg: locator<PrefsService>().appLanguage == 'en'
            ? 'No Internet Connection'
            : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = locator<PrefsService>().appLanguage == 'en'
            ? 'Something Went Wrong Try Again Later'
            : 'حدث خطأ ما حاول مرة أخرى لاحقاً';

        return OperationFilesResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }
}
