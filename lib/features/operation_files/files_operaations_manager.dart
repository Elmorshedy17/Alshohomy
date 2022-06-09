import 'package:rxdart/rxdart.dart';
import 'package:shahowmy_app/app_core/app_core.dart';
import 'package:shahowmy_app/features/get_search_info/get_search_info_repo.dart';
import 'package:shahowmy_app/features/get_search_info/get_search_info_response.dart';
import 'package:shahowmy_app/features/home/home_manager.dart';
import 'package:shahowmy_app/features/operation_files/files_operations_info_repo.dart';
import 'package:shahowmy_app/features/operation_files/files_operations_info_response.dart';
import 'package:shahowmy_app/features/operations/operations_info/get_operations_info_repo.dart';
import 'package:shahowmy_app/features/operations/operations_info/get_operations_info_response.dart';

class OperationFilesManager extends Manager<OperationFilesResponse> {
  final BehaviorSubject<OperationFilesResponse> subject =
  BehaviorSubject<OperationFilesResponse>();


  void execute({required int operationId}){
   OperationFilesRepo.getOperationFiles(operationId: operationId).then((value) {
      if (value.error == null) {
        subject.add(value);
      } else {
        subject.addError(value.error);
      }
    });
  }

  @override
  void dispose() {}

  @override
  void clearSubject() {}
}

