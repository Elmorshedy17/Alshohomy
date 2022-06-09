// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:peacock_client/app_core/resources/app_style/app_style.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shahowmy_app/app_core/resources/app_style/app_style.dart';

abstract class AppFontStyle {

  static TextStyle hugTitleBoldBlackStyle = const TextStyle(
      color: Colors.black,
      fontSize: 26,
      fontWeight: FontWeight.w800,
      height: 1.3);

  static TextStyle descBigGreyStyle = const TextStyle(
      color: AppStyle.grey,
      fontSize: 16,
      height: 1.3);


  static TextStyle labelGreyStyle = const TextStyle(
      color: AppStyle.grey,
      fontSize: 14,
      height: 1.3);

  static TextStyle labelBlackStyle = const TextStyle(
      color: Colors.black,
      fontSize: 14,
      height: 1.3);



  static TextStyle whitMedStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      height: 1.3);


  static TextStyle textFiledHintStyle = const TextStyle(
      color: AppStyle.mediumGrey,
      fontSize: 14,
      // fontWeight: FontWeight.w600,
      height: 1.3);

}
