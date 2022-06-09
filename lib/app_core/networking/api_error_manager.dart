import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../app_core.dart';

class ApiErrorManager extends Manager {
  final PublishSubject<DioError> _errorSubject = PublishSubject<DioError>();

  Stream<DioError> get error$ => _errorSubject.stream;
  Sink<DioError> get inError => _errorSubject.sink;

  @override
  void dispose() {
    _errorSubject.close();
  }

  @override
  void clearSubject() {}
}
