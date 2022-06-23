import 'package:flutter/material.dart';
import 'package:shahowmy_app/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:shahowmy_app/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:shahowmy_app/app_core/resources/app_style/app_style.dart';
import 'package:shahowmy_app/features/home/home_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shahowmy_app/app_core/app_core.dart';
import 'package:shahowmy_app/features/home/home_page.dart';


class HomeTabsWidget extends StatefulWidget {
  const HomeTabsWidget({Key? key}) : super(key: key);

  @override
  State<HomeTabsWidget> createState() => _HomeTabsWidgetState();
}

class _HomeTabsWidgetState extends State<HomeTabsWidget> {

  @override
  Widget build(BuildContext context) {
    final homeManager = context.use<HomeManager>();

    return StreamBuilder<HomeTabType>(
        stream: homeManager.status,
        initialData: HomeTabType(
          name: "",
          id: "",
          iconUrl: "",
          onPress: null,
        ),
        builder: (context, homeTabTypeSnapshot) {
          return SizedBox(
            height: 100.h,
            child: Center(
              child: ListView.builder(
                  itemCount: homeTabTypes.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){

                        if(index == 6){
                          if(context.use<PrefsService>().userObj!.contacts == "yes"){
                            Navigator.of(context).pushNamed(AppRoutesNames.contactsPage);
                          }else{
                            context.use<ToastTemplate>().show("جهات الإتصال غير متاحة");
                          }

                        }else{
                          homeManager.resetManager(
                              paginationReset: true,
                              searchReset: true,
                              statusReset: true
                          );
                          if(homeTabTypeSnapshot.data?.id == homeTabTypes[index].id){
                            homeManager.changeStatus(
                                newStatusId: "",
                                resetHomeStatus: true);
                          }else{
                            homeManager.status.sink.add(homeTabTypes[index]);
                            homeManager.changeStatus(
                                newStatusId: "${homeTabTypes[index].id}",
                                resetHomeStatus: false);
                          }
                          homeManager.inPaginationState.add(PaginationState.loading);
                          homeManager.reCallManager();


                        }

                    },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 5 - 5,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // if( index == 5) const  SizedBox(height: 13,),
                              Image.asset(homeTabTypes[index].iconUrl!,fit: BoxFit.fill,width:  100,),
                              // if( index == 5) const  SizedBox(height: 4,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(child: Text("${homeTabTypes[index].name}",maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: homeTabTypeSnapshot.data?.id == homeTabTypes[index].id? AppFontStyle.labelBlackStyle.copyWith(color: AppStyle.oil,fontWeight: FontWeight.bold) : AppFontStyle.labelBlackStyle,)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          );
        }
    );
  }
}
