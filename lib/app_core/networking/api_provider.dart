import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../app_core.dart';

class ApiService {
  static final interceptors = [
    CustomInterceptor(
        // requestRecall: DioConnectivityRequestRecall(),
        ),
    // LogInterceptor(
    //   requestHeader: true,
    //   request: true,
    //   requestBody: true,
    //   responseHeader: true,
    //   responseBody: true,
    // )

    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    )
  ];
  final Dio dioClient = Dio(
    BaseOptions(
      baseUrl: 'https://alshohomikw.com/api/',

      connectTimeout: 60000,
      receiveTimeout: 60000,
      // validateStatus: (status) => status < 500,
    ),
  )..interceptors.addAll(interceptors);
}
