import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'package:shahowmy_app/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:shahowmy_app/app_core/app_core.dart';
import 'package:shahowmy_app/features/operations/operations_post/operations_post_repo.dart';
import 'package:shahowmy_app/features/operations/operations_post/operations_post_request.dart';
import 'package:shahowmy_app/features/operations/operations_post/operations_post_response.dart';

class OperationsPostManager extends Manager<OperationsPostResponse> {
  final OperationsPostRepo _operationsPostRepo = OperationsPostRepo();
  final _prefs = locator<PrefsService>();
  String? errorDescription;

  final PublishSubject<ManagerState> _stateSubject = PublishSubject();

  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;

  Future<ManagerState> operationsPost({required OperationsPostRequest request,required int operationId}) async {
    var managerState = ManagerState.loading;
    inState.add(ManagerState.loading);
    await _operationsPostRepo.operationsPost(request,operationId).then((result) {
      if (result.status == 1) {
        inState.add(ManagerState.success);
        locator<ToastTemplate>().show("${result.message}");
        // locator<NavigationService>()
        //     .pushReplacementNamedTo(AppRoutesNames.homePage);

        // locator<NavigationService>()
        //     .pushReplacementNamedTo(AppRoutesNames.MainPageWithDrawer);

        managerState = ManagerState.success;
      } else if (result.status == 0) {
        inState.add(ManagerState.error);
        errorDescription = result.message;
        managerState = ManagerState.error;
      } else if (result.error.error is SocketException) {
        inState.add(ManagerState.socketError);
        errorDescription = _prefs.appLanguage == 'en'
            ? 'No Internet Connection'
            : 'لا يوجد إتصال بالشبكة';
        managerState = ManagerState.socketError;
      } else {
        inState.add(ManagerState.unknownError);
        errorDescription = _prefs.appLanguage == 'en'
            ? "Unexpected error occurred"
            : 'حدث خظأ غير متوقع';
        managerState = ManagerState.unknownError;
      }
    });
    return managerState;
  }



  @override
  void dispose() {
    _stateSubject.close();
  }

  @override
  void clearSubject() {}
}
