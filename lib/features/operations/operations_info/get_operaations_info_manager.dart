import 'package:rxdart/rxdart.dart';
import 'package:shahowmy_app/app_core/app_core.dart';
import 'package:shahowmy_app/features/get_search_info/get_search_info_repo.dart';
import 'package:shahowmy_app/features/get_search_info/get_search_info_response.dart';
import 'package:shahowmy_app/features/home/home_manager.dart';
import 'package:shahowmy_app/features/operations/operations_info/get_operations_info_repo.dart';
import 'package:shahowmy_app/features/operations/operations_info/get_operations_info_response.dart';

class OperationsInfoManager extends Manager<OperationsInfoResponse> {
  final BehaviorSubject<OperationsInfoResponse> subject =
  BehaviorSubject<OperationsInfoResponse>();





  void execute({required int operationId}){
   OperationsInfoRepo.getOperationsInfo(operationId: operationId).then((value) {
      if (value.error == null) {
        subject.add(value);
        for (var state in value.data!.choicesStatus!) {
          if(state.active == "yes"){
            locator<HomeManager>().choicesStatusSubject.sink.add(state);
          }
        }
        for (var transfer in value.data!.choicesTransfer!) {
          if(transfer.active == "yes"){
            locator<HomeManager>().choicesTransferSubject.sink.add(transfer);
          }
        }

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

