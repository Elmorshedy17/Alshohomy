import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shahowmy_app/app_core/app_core.dart';
import 'package:shahowmy_app/app_core/resources/app_assets/app_assets.dart';
import 'package:shahowmy_app/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:shahowmy_app/features/home/home_manager.dart';
import 'package:shahowmy_app/features/home/home_page.dart';
import 'package:shahowmy_app/features/operation_files/files_operaations_manager.dart';
import 'package:shahowmy_app/features/operation_files/files_operations_info_response.dart';
import 'package:shahowmy_app/shared/main_button/main_button_widget.dart';
import 'package:shahowmy_app/shared/selection_widget/selection_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shahowmy_app/shared/url_launcher/url_launcher.dart';


void showDownloadDialog(context,operationId) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration:const Duration(milliseconds: 500),
    pageBuilder: (_, __, ___) {
      return FilesWidget(operationId: operationId,);
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




class FilesWidget extends StatefulWidget {
  final int operationId;

   FilesWidget({Key? key,required this.operationId}) : super(key: key);

  @override
  State<FilesWidget> createState() => _FilesWidgetState();
}

class _FilesWidgetState extends State<FilesWidget> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(!locator<OperationFilesManager>().subject.hasValue){
      locator<OperationFilesManager>().execute(operationId: widget.operationId);
    }
  }


  @override
  Widget build(BuildContext context) {

    final operationFilesManager = context.use<OperationFilesManager>();


    return Observer<OperationFilesResponse>(
        stream: operationFilesManager.subject.stream,
        onRetryClicked: (){
          operationFilesManager.execute(operationId: widget.operationId);
        },
        onSuccess: (context, operationFilesSnapshot) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 25),
              height: MediaQuery.of(context).size.height * .5,
              width: MediaQuery.of(context).size.width * .8,
              // child:const SizedBox.expand(child: FlutterLogo()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:const EdgeInsets.only(top: 15,right: 10,left: 10),
                    child: Column(
                      children: [
                        Text("الملف",style: AppFontStyle.labelBlackStyle.copyWith(fontWeight: FontWeight.bold,fontSize: 16),),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      // shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      itemCount: operationFilesSnapshot.data!.files!.length,
                      separatorBuilder: (_, index) => const Divider(
                        height: 45,
                      ),
                      itemBuilder: (_, index) => InkWell(
                        onTap: (){

                        },
                        child: InkWell(
                          onTap: (){
                            if( operationFilesSnapshot.data!.files![index].link != "" || operationFilesSnapshot.data!.files![index].link != null)
                            openURL(operationFilesSnapshot.data!.files![index].link);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text("${operationFilesSnapshot.data!.files![index].name}",style: AppFontStyle.labelBlackStyle,)),
                              const SizedBox(
                                width: 15,
                              ),
                              SvgPicture.asset(
                                AppAssets.download,
                                // color: Colors.brown,
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: MainButtonWidget(title: "الغاء",width: 150.w,onClick: (){
                      Navigator.of(context).pop();
                    }),
                  ),
                ],
              ),
              margin:const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
            ),
          ),
        );
      }
    );
  }
}
