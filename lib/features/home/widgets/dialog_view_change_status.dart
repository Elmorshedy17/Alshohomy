import 'package:flutter/material.dart';
import 'package:shahowmy_app/app_core/app_core.dart';
import 'package:shahowmy_app/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:shahowmy_app/features/home/home_manager.dart';
import 'package:shahowmy_app/features/home/home_page.dart';
import 'package:shahowmy_app/features/operations/operations_info/get_operaations_info_manager.dart';
import 'package:shahowmy_app/features/operations/operations_info/get_operations_info_response.dart';
import 'package:shahowmy_app/features/operations/operations_post/operations_post_manager.dart';
import 'package:shahowmy_app/features/operations/operations_post/operations_post_request.dart';
import 'package:shahowmy_app/shared/custom_list_tile/custom_list_tile.dart';
import 'package:shahowmy_app/shared/main_button/main_button_widget.dart';
import 'package:shahowmy_app/shared/selection_widget/selection_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


void showChangeStatusDialog(context,operationId) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration:const Duration(milliseconds: 500),
    pageBuilder: (_, __, ___) {
      return ChangeStatusWidget(operationId: operationId,);
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin:const Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin:const Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}

class ChangeStatusWidget extends StatefulWidget {
  final int operationId;
   ChangeStatusWidget({Key? key,required this.operationId}) : super(key: key);

  @override
  State<ChangeStatusWidget> createState() => _ChangeStatusWidgetState();
}

class _ChangeStatusWidgetState extends State<ChangeStatusWidget> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(!locator<OperationsInfoManager>().subject.hasValue){
      locator<OperationsInfoManager>().execute(operationId: widget.operationId);
    }
  }

  // final oldStatusId = locator<HomeManager>().choicesStatusSubject.value.id;

  @override
  Widget build(BuildContext context) {
    final operationsInfoManager = context.use<OperationsInfoManager>();
    final operationsPostManager = context.use<OperationsPostManager>();
    final homeManager = context.use<HomeManager>();


    return Observer<OperationsInfoResponse>(
        stream: operationsInfoManager.subject.stream,
        onRetryClicked: (){
          operationsInfoManager.execute(operationId: widget.operationId);
        },
        onSuccess: (context, operationsInfoSnapshot) {
        return StreamBuilder<ManagerState>(
            initialData: ManagerState.idle,
            stream: operationsPostManager.state$,
            builder: (context, AsyncSnapshot<ManagerState> stateSnapshot) {
              return FormsStateHandling(
                managerState: stateSnapshot.data,
                errorMsg: operationsPostManager.errorDescription,
                onClickCloseErrorBtn: () {
                  operationsPostManager.inState.add(ManagerState.idle);
                },
              child: Center(
                child: Material(
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      Container(
                        padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                        height: MediaQuery.of(context).size.height * .6,
                        width: MediaQuery.of(context).size.width * .8,
                        // child:const SizedBox.expand(child: FlutterLogo()),
                        child: ListView(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding:const EdgeInsets.only(top: 15,right: 20,left: 20),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("معاملة ${operationsInfoSnapshot.data!.id}#",style: AppFontStyle.labelGreyStyle,),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  // Text("تحويل الحالة",style: AppFontStyle.labelBlackStyle.copyWith(fontWeight: FontWeight.bold,fontSize: 16),),
                                  // const SizedBox(
                                  //   height: 15,
                                  // ),
                                ],
                              ),
                            ),
                            StreamBuilder<ChoicesStatus>(
                                initialData: ChoicesStatus(
                                    name: "",
                                    id: "",
                                    active: ""
                                ),
                                stream: homeManager.choicesTransferSubject.stream,
                                builder: (context, choicesTransferSnapshot) {
                                  return CustomAnimatedOpenTile(
                                    headerTxt:"تعديل الحالة",
                                    body: SizedBox(
                                      height: MediaQuery.of(context).size.height * .3,
                                      child: ListView.separated(
                                        // shrinkWrap: true,
                                        // physics: const NeverScrollableScrollPhysics(),
                                        itemCount: operationsInfoSnapshot.data!.choicesTransfer!.length,
                                        separatorBuilder: (_, index) => const Divider(),
                                        itemBuilder: (_, index) => InkWell(
                                          onTap: (){
                                            homeManager.choicesTransferSubject.sink.add(operationsInfoSnapshot.data!.choicesTransfer![index]);
                                          },
                                          child: SelectionWidget(
                                            hasBorder: false,
                                            title: operationsInfoSnapshot.data!.choicesTransfer![index].name!,
                                            isSelected: choicesTransferSnapshot.data!.id == operationsInfoSnapshot.data!.choicesTransfer![index].id,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            ),

                            const SizedBox(
                              height: 15,
                            ),
                            StreamBuilder<ChoicesStatus>(
                                initialData: ChoicesStatus(
                                    name: "",
                                    id: "",
                                    active: ""
                                ),
                                stream: homeManager.choicesStatusSubject.stream,
                                builder: (context, choicesStatusSnapshot) {
                                  return CustomAnimatedOpenTile(
                                    headerTxt:"تحويل الحالة",
                                    body: SizedBox(
                                      height: MediaQuery.of(context).size.height * .3,
                                      child: ListView.separated(
                                        // shrinkWrap: true,
                                        // physics: const NeverScrollableScrollPhysics(),
                                        itemCount: operationsInfoSnapshot.data!.choicesStatus!.length,
                                        separatorBuilder: (_, index) => const Divider(),
                                        itemBuilder: (_, index) => InkWell(
                                          onTap: (){
                                            homeManager.choicesStatusSubject.sink.add(operationsInfoSnapshot.data!.choicesStatus![index]);
                                          },
                                          child: SelectionWidget(
                                            hasBorder: false,
                                            title: operationsInfoSnapshot.data!.choicesStatus![index].name!,
                                            isSelected: choicesStatusSnapshot.data!.id == operationsInfoSnapshot.data!.choicesStatus![index].id,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            ),
                            // Expanded(
                            //   child: ListView.separated(
                            //     // shrinkWrap: true,
                            //     // physics: const NeverScrollableScrollPhysics(),
                            //     itemCount: operationsInfoSnapshot.data!.choicesStatus!.length,
                            //     separatorBuilder: (_, index) => const Divider(),
                            //     itemBuilder: (_, index) => InkWell(
                            //       onTap: (){
                            //         homeManager.choicesStatusSubject.sink.add(operationsInfoSnapshot.data!.choicesStatus![index]);
                            //         print("${changeStatus[index].id!}");
                            //       },
                            //       child: SelectionWidget(
                            //         hasBorder: false,
                            //         title: operationsInfoSnapshot.data!.choicesStatus![index].name!,
                            //         isSelected: choicesStatusSnapshot.data!.id == operationsInfoSnapshot.data!.choicesStatus![index].id,
                            //       ),
                            //     ),
                            //   ),
                            // ),

                            const SizedBox(
                              height: 25,
                            ),

                          ],
                        ),
                        margin:const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Center(
                        child: MainButtonWidget(title: "تعديل",width: 150.w,onClick: () async {
                          // print("hello");
                          // print("oldStatusId${oldStatusId} \\ ${homeManager.choicesStatusSubject.value.id}");
                          if(homeManager.choicesStatusSubject.value.id == null){
                            // Navigator.of(context).pop();
                            locator<ToastTemplate>().show("برجاء تحديد الحالة الجديده");
                          }else{
                            await operationsPostManager.operationsPost(
                              request: OperationsPostRequest(
                                status: homeManager.choicesStatusSubject.value.id,
                                transfer:  homeManager.choicesTransferSubject.value.id,
                              ),
                              operationId:  widget.operationId,
                            ).then((value) {
                              if (value == ManagerState.success){
                                locator<OperationsInfoManager>().execute(operationId: widget.operationId);
                                // homeManager.resetStatusTransfer();
                                Navigator.of(context).pop();
                              }

                            });
                          }
                        }),
                      ),)
                    ],
                  ),
                ),
              ),
            );
          }
        );
      }
    );
  }
}
