import 'package:rxdart/rxdart.dart';

import 'app_core.dart';

class LoadingManager extends Manager {
  final PublishSubject<bool> _loadingSubject = PublishSubject<bool>();
  Stream<bool> get loading$ => _loadingSubject.stream;
  Sink<bool> get inLoading => _loadingSubject.sink;

  final PublishSubject<ManagerState> _stateSubject = PublishSubject();

  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;

  @override
  void dispose() {
    _loadingSubject.close();
    _stateSubject.close();
  }

  @override
  void clearSubject() {}
}
