import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:shahowmy_app/app_core/app_core.dart';
import 'package:shahowmy_app/app_core/resources/app_assets/app_assets.dart';
import 'package:shahowmy_app/features/home/home_repo.dart';
import 'package:shahowmy_app/features/home/home_response.dart';
import 'package:shahowmy_app/features/operations/operations_info/get_operations_info_response.dart';
import 'package:shahowmy_app/shared/domain/operations.dart';

import '../get_search_info/get_search_info_response.dart';


enum PaginationState {
 loading,
 success,
 error,
 idle,
}

 class HomeManager extends Manager<HomeResponse> {




  String? statusId = "";
  String? fromId = "";
  String? word ="";
  String? searchId ="";

  void changeFrom({required String? newFromId}){
   fromStatus.sink.add(HomeTabType(
    name: "",
    id: "",
    iconUrl: "",
    onPress: null,
   ));

  fromId = "$newFromId";
 }


  void changeStatus({required String? newStatusId}){
   statusSubject.sink.add(Destination(
    name: "حالة",
    id: "",
   ));

   statusId = "$newStatusId";
  }

  // final ValueNotifier<int> _selectionNotifier = ValueNotifier(-1);
  // set inSelected(int newValue) => _selectionNotifier.value = newValue;
  // ValueNotifier<int> get notifier => _selectionNotifier;
  // int get selectedIndex => _selectionNotifier.value;


  final BehaviorSubject<Destination> destinationSubject =
  BehaviorSubject<Destination>();

  final BehaviorSubject<ChoicesStatus> choicesStatusSubject =
  BehaviorSubject<ChoicesStatus>.seeded(ChoicesStatus(
   name: "",
   id: "",
   active: ""
  ));

  final BehaviorSubject<ChoicesStatus> choicesTransferSubject =
  BehaviorSubject<ChoicesStatus>.seeded(ChoicesStatus(
      name: "",
      id: "",
      active: ""
  ));


  void resetStatusTransfer (){
   choicesTransferSubject.sink.add(ChoicesStatus(
       name: "",
       id: "",
       active: ""
   ));
   choicesStatusSubject.sink.add(ChoicesStatus(
       name: "",
       id: "",
       active: ""
   ));
  }

  final BehaviorSubject<Destination> statusSubject =
  BehaviorSubject<Destination>();

  int currentPageNum = 1;
  int maxPageNum = 5;
  int totalItemsCount = 0;

  List<Operations> operations = [];

  final PublishSubject<HomeResponse> _homeResponseSubject =
  PublishSubject<HomeResponse>();

  BehaviorSubject<HomeTabType> fromStatus =
  BehaviorSubject.seeded(HomeTabType(
   name: "",
   id: "",
   iconUrl: "",
   onPress: null,
  ));

  BehaviorSubject<HomeTabType> fromTempStatus =
  BehaviorSubject.seeded(HomeTabType(
   name: "",
   id: "",
   iconUrl: "",
   onPress: null,
  ));





  Stream<HomeResponse> get response$ =>
      _homeResponseSubject.stream;

  final PublishSubject<PaginationState> _paginationStateSubject =
  PublishSubject<PaginationState>();
  Stream<PaginationState> get paginationState$ =>
      _paginationStateSubject.stream;
  Sink<PaginationState> get inPaginationState => _paginationStateSubject.sink;

  ScrollController scrollController = ScrollController();

  HomeManager() {
   scrollController.addListener(() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
     await loadMore();
    }
   });
  }


  Future<void> loadMore() async {
   if (maxPageNum >= currentPageNum) {
    inPaginationState.add(PaginationState.loading);
    await HomeRepo.home(pageNum: currentPageNum,
    fromId: "$fromId",
    status: "$statusId",
    id: "$searchId",
    name: "$word",
    destinationId: "${destinationSubject.value.id}")
        .then((result) {
     if (result.error == null) {
      // if (result.status == 1) {
      currentPageNum = result.data!.info!.currentPage! + 1;
      inPaginationState.add(PaginationState.success);
      maxPageNum = result.data!.info!.lastPage ?? 0;
      _homeResponseSubject.add(result);
      // }
     } else {
      inPaginationState.add(PaginationState.error);
     }
    });
   }
  }

  Future<void> onErrorLoadMore() async {
   if (maxPageNum >= currentPageNum) {
    inPaginationState.add(PaginationState.loading);
    await HomeRepo.home(pageNum: currentPageNum,
        fromId: "$fromId",
        status: "$statusId",
        id: "$searchId",
        name: "$word",
        destinationId: "${destinationSubject.value.id}")
        .then((result) {
     if (result.error == null) {
      // if (result.status == true) {
      currentPageNum = result.data!.info!.currentPage! + 1;
      inPaginationState.add(PaginationState.success);
      // currentPageNum++;
      maxPageNum = result.data!.info!.lastPage ?? 0;
      _homeResponseSubject.add(result);
      // }
     } else {
      inPaginationState.add(PaginationState.error);
     }
    });
   }
  }

  updateHomeList({
   required int totalItemsCount,
   required List<Operations> snapshotHome,
  }) {
   totalItemsCount = totalItemsCount;
   snapshotHome.forEach((notification) {
    if (operations.length < totalItemsCount) {
     if (!operations.contains(notification)) {
      operations.add(notification);
     }
    }
   });
  }

  void reCallManager() {
   Stream.fromFuture(
    HomeRepo.home(pageNum: currentPageNum,
        fromId: "$fromId",
        status: "$statusId",
        id: "$searchId",
        name: "$word",
        destinationId: "${destinationSubject.value.id}"),
   ).listen((result) {
    if (result.error == null) {
     _homeResponseSubject.add(result);
     currentPageNum = result.data!.info!.currentPage! + 1;
    } else {
     _homeResponseSubject.addError(result.error);
    }
   });
  }

  void resetManager({
   required paginationReset,
   required searchReset,
   required statusReset}) {
   if(searchReset == true){
    destinationSubject.sink.add(Destination(
     name: "جهة",
     id: "",
    ));
    statusSubject.sink.add(Destination(
     name: "حالة",
     id: "",
    ));
    fromTempStatus.sink.add(HomeTabType(
     name: "",
     id: "",
     iconUrl: "",
     onPress: null,
    ));
    word ="";
    searchId ="";
   }
   if(statusReset == true){
    fromStatus.sink.add(HomeTabType(
     name: "",
     id: "",
     iconUrl: "",
     onPress: null,
    ));


    statusId = "";
     fromId = "";
   }
   if(paginationReset == true){
    currentPageNum = 1;
    maxPageNum = 5;
    totalItemsCount = 0;
    operations.clear();
    _homeResponseSubject.drain();
   }
  }

  @override
  void clearSubject() {}

  @override
  void dispose() {}


 }

class  HomeTabType{
 String? id;
 String? name,iconUrl;
 VoidCallback? onPress;

 HomeTabType({
  this.id,
  this.name,
  this.onPress,
  this.iconUrl
 });

}



List<HomeTabType> homeTabTypes = [
 HomeTabType(
     id: "inbox",
     name: "الكل",
     iconUrl: AppAssets.inbox,
     onPress:null
 ),
 HomeTabType(
     id: "pending",
     name: "مسودة",
     iconUrl: AppAssets.draft,
     onPress:null
 ),
 HomeTabType(
     id: "scheduled",
     name: "مؤجلة",
     iconUrl: AppAssets.delay,
     onPress:null
 ),
 HomeTabType(
     id: "delay",
     name: "متأخر",
     iconUrl: AppAssets.late,
     onPress:null
 ),
 HomeTabType(
     id: "done",
     name: "مكتمل",
     iconUrl: AppAssets.done,
     onPress:null
 ),
 HomeTabType(
     id: "today",
     name: "اليوم",
     iconUrl: AppAssets.today,
     onPress:null
 ),
 if(locator<PrefsService>().userObj != null)
  if(locator<PrefsService>().userObj!.contacts == "yes")
   HomeTabType(
       id: "contacts",
       name: "جهات الاتصال",
       iconUrl: AppAssets.contacts,
       onPress:null
   ),
 if(locator<PrefsService>().userObj != null)
  if(locator<PrefsService>().userObj!.statistics == "yes")
   HomeTabType(
       id: "statistics",
       name: "الاحصائيات",
       iconUrl: AppAssets.statics,
       onPress:null
   ),
];




List<HomeTabType> homeTabTypesFrom = [
 HomeTabType(
     id: "inbox",
     name: "الكل",
     iconUrl: AppAssets.inbox,
     onPress:null
 ),
 HomeTabType(
     id: "pending",
     name: "مسودة",
     iconUrl: AppAssets.draft,
     onPress:null
 ),
 HomeTabType(
     id: "scheduled",
     name: "مؤجلة",
     iconUrl: AppAssets.delay,
     onPress:null
 ),
 HomeTabType(
     id: "delay",
     name: "متأخر",
     iconUrl: AppAssets.late,
     onPress:null
 ),
 HomeTabType(
     id: "done",
     name: "مكتمل",
     iconUrl: AppAssets.done,
     onPress:null
 ),
 HomeTabType(
     id: "today",
     name: "اليوم",
     iconUrl: AppAssets.today,
     onPress:null
 ),
];