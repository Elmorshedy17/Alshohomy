import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shahowmy_app/app_core/resources/app_assets/app_assets.dart';
import 'package:shahowmy_app/app_core/resources/app_style/app_style.dart';
import 'package:shahowmy_app/features/home/home_manager.dart';
import 'package:shahowmy_app/features/home/home_response.dart';
import 'package:shahowmy_app/features/home/widgets/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shahowmy_app/features/home/widgets/dialog_download_file.dart';
import 'package:shahowmy_app/features/home/widgets/home_item.dart';
import 'package:shahowmy_app/features/home/widgets/dialog_view_change_status.dart';
import 'package:shahowmy_app/features/home/widgets/home_page_tabs.dart';
import 'package:shahowmy_app/app_core/app_core.dart';
import 'package:shahowmy_app/shared/not_available_widget/not_available_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late final HomeManager homeManager;


  bool hasInitialDependencies = false;




  @override
  void didChangeDependencies() {
    if (!hasInitialDependencies) {
      hasInitialDependencies = true;
      homeManager = context.use<HomeManager>();
      homeManager.resetManager(
        paginationReset: true,
        searchReset: true,
        statusReset: true
      );
      homeManager.reCallManager();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
        final homeManager = context.use<HomeManager>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar:const PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: HomeAppBar(
          )),
      body: Observer<HomeResponse>(
          onRetryClicked: homeManager.reCallManager,
          // onWaiting: (context) => NotificationPageLoading(),
          // manager: notificationsManager,
          stream: homeManager.response$,
          onSuccess: (context, homeSnapshot) {
            homeManager.updateHomeList(
                totalItemsCount:
                homeSnapshot.data?.info?.total ?? 0,
                snapshotHome:
                homeSnapshot.data?.operations ?? []);
            return Container(
              padding: const EdgeInsets.all(15),
              child: SafeArea(
                child: Stack(
                  children: [
               homeManager.operations.isNotEmpty ?     FadeInLeftBig(
                      child: Container(
                        padding: EdgeInsets.only(top: 100.h,),
                        child: ListView(
                          physics: const ClampingScrollPhysics(),
                          controller: homeManager.scrollController,
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: homeManager.operations.length,
                                physics:const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return HomeItemData(
                                    name: homeManager.operations[index].name,
                                    hash: "#${homeManager.operations[index].id}",
                                    status:homeManager.operations[index].status,
                                    title: homeManager.operations[index].destination,
                                    id: "${homeManager.operations[index].id}",
                                    phone: homeManager.operations[index].phone,
                                    editOnClick: (){
                                      // homeManager.inSelected = changeStatus[index].id!;
                                      showChangeStatusDialog(context,homeManager.operations[index].id);
                                    },
                                    downloadFilesOnClick: (){
                                      showDownloadDialog(context,homeManager.operations[index].id);
                                    },
                                  );
                                }),

                            StreamBuilder<PaginationState>(
                                initialData: PaginationState.idle,
                                stream: homeManager.paginationState$,
                                builder: (context, paginationStateSnapshot) {
                                  if (paginationStateSnapshot.data ==
                                      PaginationState.loading) {
                                    return const ListTile(
                                        title: Center(
                                          child: SpinKitWave(
                                            color: AppStyle.oil,
                                            itemCount: 5,
                                            size: 30.0,
                                          ),
                                        ));
                                  }
                                  if (paginationStateSnapshot.data ==
                                      PaginationState.error) {
                                    return Container(
                                      color: AppStyle.grey,
                                      child: ListTile(
                                        leading:const Icon(Icons.error),
                                        title: Text(
                                          locator<PrefsService>().appLanguage == 'en' ? 'Something Went Wrong Try Again Later' : 'حدث خطأ ما حاول مرة أخرى لاحقاً',
                                          style:const TextStyle(color: Colors.white),
                                        ),
                                        trailing: ElevatedButton(
                                          onPressed: () async {
                                            await homeManager.onErrorLoadMore();
                                          },
                                          child: Text(
                                              locator<PrefsService>().appLanguage == 'en' ? 'Retry' : 'أعد المحاولة'),
                                        ),
                                      ),
                                    );
                                  }
                                  return  const SizedBox(
                                    width: 0,
                                    height: 0,
                                  );
                                }),
                          ],
                        ),
                      ),
                    ):Center(
                 child: NotAvailableComponent(
                   view: Icon(Icons.warning_amber_outlined,size: 125.sp,color: Colors.yellow.withOpacity(.3),),
                   title: 'لا توجد عمليات متاحه',
                 ),
               ),
                     Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child:    FadeInRightBig(child:const HomeTabsWidget()),),
                  ],
                ),
              ),
            );
          }
      ),

    );
  }
}








class ChangeStatus {
  int? id;
  String? status;
  bool? isSelected;
  ChangeStatus({this.id,this.status,this.isSelected});
}


List<ChangeStatus> changeStatus = [
  ChangeStatus(
    id: 1,
    status: "وزير",
    isSelected: true,
  ),  ChangeStatus(
    id: 2,
    status: "موظف",
    isSelected: false,
  ),  ChangeStatus(
    id: 3,
    status: "مؤجل",
    isSelected: false,
  ),  ChangeStatus(
    id: 4,
    status: "مدير",
    isSelected: false,
  ),  ChangeStatus(
    id: 5,
    status: "مكتمل",
    isSelected: false,
  ),
];
//
// class IdTitle {
//   int? id;
//   String? title;
//   IdTitle({this.id,this.title});
// }