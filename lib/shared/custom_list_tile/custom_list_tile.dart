import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shahowmy_app/app_core/app_core.dart';

class CustomAnimatedOpenTile extends StatelessWidget {
  final vsync;
  final String? headerTxt;
  final Widget? body;
  final bool? outValue;

  CustomAnimatedOpenTile(
      {this.vsync,
        this.headerTxt,
        this.body,
        this.outValue,
      });

  // static bool? listener;

    final BehaviorSubject<bool> open = BehaviorSubject<bool>.seeded(false);
  final prefs = locator<PrefsService>();

  void dispose() {
    // open.add(false);
    open.close();
  }

   void openToggle() {
    if (open.value == false) {
      open.add(true);
    } else {
      open.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        initialData: outValue,
        stream: open.stream,
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
                    onTap: () {
                      openToggle();
                    },
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
                                  Text('$headerTxt',),
                                  openSnapshot.data == true  ? const Icon(Icons.keyboard_arrow_up,color: Colors.grey,): Icon(Icons.keyboard_arrow_down,color: Colors.grey,)

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

