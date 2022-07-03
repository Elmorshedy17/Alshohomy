import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shahowmy_app/app_core/resources/app_assets/app_assets.dart';
import 'package:shahowmy_app/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:shahowmy_app/shared/selection_widget/selection_widget.dart';


class HomeItemData extends StatelessWidget {

  String?id, title,name,status,hash,phone;
  final Function? editOnClick,downloadFilesOnClick,moreOnClick;



  HomeItemData({Key? key,this.hash,this.name,this.phone,this.status,this.title,this.id,this.editOnClick,this.downloadFilesOnClick,this.moreOnClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        padding:const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: Text("$title",style: AppFontStyle.labelGreyStyle,)),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.redCircle,
                      // color: Colors.brown,
                      height: 10,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text("$status",style: AppFontStyle.labelGreyStyle.copyWith(fontSize: 13),),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(child: Text("$name",style: AppFontStyle.labelBlackStyle,maxLines: 2,)),
                Text("$phone",style: AppFontStyle.labelGreyStyle,)
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(child: Text("$hash",style: AppFontStyle.labelBlackStyle,)),
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        moreOnClick!();
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.info,
                            color: Colors.grey,
                            height: 12,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("المزيد",style: AppFontStyle.labelBlackStyle.copyWith(fontSize:12 ),)

                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: (){
                        editOnClick!();
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.edit,
                            // color: Colors.brown,
                            height: 12,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("تعديل",style: AppFontStyle.labelBlackStyle.copyWith(fontSize:12 ),)

                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: (){
                        downloadFilesOnClick!();
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.files,
                            // color: Colors.brown,
                            height: 12,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("الملفات",style: AppFontStyle.labelBlackStyle.copyWith(fontSize:12 ),)
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

