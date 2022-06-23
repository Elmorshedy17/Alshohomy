import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shahowmy_app/app_core/app_core.dart';
import 'package:shahowmy_app/features/get_search_info/get_search_info_manager.dart';

class CustomAnimatedOpenTileWithoutDispose extends StatelessWidget {



  final vsync;
  final String? headerTxt;
  final Widget? body;
  final Widget? headerWidget;
  final bool? outValue;

  CustomAnimatedOpenTileWithoutDispose(
      {this.vsync,
        this.headerTxt,
        this.body,
        this.headerWidget,
        this.outValue,
      });

  // static bool? listener;

  final prefs = locator<PrefsService>();
  final searchInfoManager = locator<SearchInfoManager>();

  // void dispose() {
  //   // open.add(false);
  //   open.close();
  // }

  void openToggle() {
    if (searchInfoManager.open.value == false) {
      searchInfoManager.open.add(true);
    } else {
      searchInfoManager.open.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        initialData: outValue,
        stream: searchInfoManager.open.stream,
        builder: (context, openSnapshot) {
          // if(listener == false){
          //   open.add(false);
          //   listener = true;
          // }
          return AnimatedSize(
            duration: const Duration(milliseconds: 400),
            reverseDuration:const Duration(milliseconds: 400),
            alignment: Alignment.topCenter,
            vsync: vsync,
            curve: Curves.easeIn,
            child: InkWell(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  InkWell(
                    onTap:searchInfoManager.open.value == false ? () {
                      // searchInfoManager.open.value == false ? searchInfoManager.open.sink.add(true) : (){};
                      openToggle();
                    }:null,
                    child: Container(
                        key: UniqueKey(),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if(headerTxt != null)   Text('$headerTxt',),
                                  Container(
                                    child: headerWidget,
                                  ),
                                  SizedBox(
                                    width: 75,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            openToggle();
                                          },
                                          child:  openSnapshot.data == true  ? const Icon(Icons.keyboard_arrow_up,color: Colors.grey,): Icon(Icons.keyboard_arrow_down,color: Colors.grey,)
                                          ,
                                        ),
                                      ],
                                    ),
                                  )

                                ],
                              ),
                            ),
                            // openSnapshot.data == true ?
                            Container(
                              margin:const EdgeInsets.symmetric(vertical: 10),
                              width: double.infinity,
                              color: Colors.grey.withOpacity(.7),
                              height: 1,
                            )
                            // : Container(),

                          ],
                        )),
                  ),


                  openSnapshot.data == true
                      ? SizedBox(
                    width: double.infinity,
                    key: UniqueKey(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          // padding: EdgeInsets.symmetric(vertical:bodyPaddingV! ,horizontal: bodyPaddingH !),
                          child: body!,
                        ),
                      ],
                    ),
                  )
                      : Container(),
                ],
              ),
            ),
          );
        });
  }
}

