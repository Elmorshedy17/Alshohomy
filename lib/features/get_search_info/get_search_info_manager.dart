import 'package:rxdart/rxdart.dart';
import 'package:shahowmy_app/app_core/app_core.dart';
import 'package:shahowmy_app/features/get_search_info/get_search_info_repo.dart';
import 'package:shahowmy_app/features/get_search_info/get_search_info_response.dart';

class SearchInfoManager extends Manager<SearchInfoResponse> {
  final BehaviorSubject<SearchInfoResponse> subject =
  BehaviorSubject<SearchInfoResponse>();





  void execute(){
   SearchInfoRepo.getSearchInfo().then((value) {
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

