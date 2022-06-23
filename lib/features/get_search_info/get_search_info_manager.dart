import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shahowmy_app/app_core/app_core.dart';
import 'package:shahowmy_app/features/get_search_info/get_search_info_repo.dart';
import 'package:shahowmy_app/features/get_search_info/get_search_info_response.dart';

class SearchInfoManager extends Manager<SearchInfoResponse> {


  final TextEditingController searchDestinationController = TextEditingController();


  final BehaviorSubject<SearchInfoResponse> subject =
  BehaviorSubject<SearchInfoResponse>();

  final BehaviorSubject<bool> open = BehaviorSubject<bool>.seeded(false);


  final BehaviorSubject<List<Destination>> destinationsSubject =
  BehaviorSubject<List<Destination>>();

  List<Destination> destinations = [];


  void resetDestinationsList(){
    destinations.clear();
    open.sink.add(false);
    // searchDestinationController.clear();
    destinations = List.from(subject.value.data!.destination!);
    destinationsSubject.sink.add(destinations);
  }


  void searchInDestinations({required String word}){
    destinations.clear();
    for (var destination in subject.value.data!.destination!) {
      if(destination.name!.contains(word)){
        destinations.add(destination);
      }
    }
    destinationsSubject.sink.add(destinations);
  }


  void execute(){
   SearchInfoRepo.getSearchInfo().then((value) {
      if (value.error == null) {
        subject.add(value);
        destinations = List.from(value.data!.destination!);
        destinationsSubject.sink.add(destinations);

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

