// import 'package:data_connection_checker/data_connection_checker.dart';
// import 'package:rxdart/rxdart.dart';
//
// enum InternetStatus {
//   Online,
//   Offline,
// }
//
// class ConnectionCheckerManager {
//   static final ConnectionCheckerManager _singleton = ConnectionCheckerManager._internal();
//
//   PublishSubject<InternetStatus> _connectionStatusSubject = PublishSubject<InternetStatus>();
//
//   Stream<InternetStatus> get getConnectionStatus$ => _connectionStatusSubject.stream;
//
//   factory ConnectionCheckerManager() {
//     return _singleton;
//   }
//
//   ConnectionCheckerManager._internal() {
//     DataConnectionChecker().onStatusChange.listen((status) {
//       _connectionStatusSubject.add(_getStatusFromResult(status));
//     });
//   }
//
//   // Convert from the third part enum to our own enum
//   InternetStatus _getStatusFromResult(DataConnectionStatus status) {
//     switch (status) {
//       case DataConnectionStatus.connected:
//         return InternetStatus.Online;
//
//       case DataConnectionStatus.disconnected:
//         return InternetStatus.Offline;
//       default:
//         return InternetStatus.Offline;
//     }
//   }
// }
