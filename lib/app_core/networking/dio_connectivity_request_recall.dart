// import 'dart:async';
//
// import 'package:dio/dio.dart';
//
// import '../app_core.dart';
//
// class DioConnectivityRequestRecall {
//   Future<Response> scheduleRequestRecall(RequestOptions requestOptions) async {
//     StreamSubscription streamSubscription;
//     final responseCompleter = Completer<Response>();
//
//     streamSubscription = locator<ConnectionCheckerManager>()
//         .getConnectionStatus$
//         .listen((status) {
//       if (status == InternetStatus.Online) {
//         // Ensure that only one retry happens per connectivity change by cancelling the listener.
//         streamSubscription.cancel();
//         // Complete the completer instead of returning
//         responseCompleter.complete(
//           locator<ApiService>().dioClient.request(
//                 requestOptions.path,
//                 cancelToken: requestOptions.cancelToken,
//                 data: requestOptions.data,
//                 onReceiveProgress: requestOptions.onReceiveProgress,
//                 onSendProgress: requestOptions.onSendProgress,
//                 queryParameters: requestOptions.queryParameters,
//                 options: requestOptions,
//               ),
//         );
//       }
//     });
//     return responseCompleter.future;
//   }
// }
