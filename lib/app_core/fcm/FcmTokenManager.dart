import 'package:rxdart/rxdart.dart';

import '../app_core.dart';

class FcmTokenManager extends Manager {
  // String _fcmToken = '';

  String notificationType = "general";
  final BehaviorSubject<String> _fcmTokenSubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inFcm => _fcmTokenSubject.sink;
  String get currentFcmToken => _fcmTokenSubject.value;

  final BehaviorSubject<String> _fcmTitleSubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inFcmTitle => _fcmTitleSubject.sink;
  String get currentFcmTitle => _fcmTitleSubject.value;

  final BehaviorSubject<String> _fcmBodySubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inFcmBody => _fcmBodySubject.sink;
  String get currentFcmBody => _fcmBodySubject.value;

  @override
  void dispose() {
    _fcmTokenSubject.close();
    _fcmTitleSubject.close();
    _fcmBodySubject.close();
  }

  @override
  void clearSubject() {}
}
