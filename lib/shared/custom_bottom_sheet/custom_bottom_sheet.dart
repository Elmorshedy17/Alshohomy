import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

void customBottomSheet(
    {required BuildContext context,
      double topBorderRadius = 20,
      double bottomSheetHeight = 0.7,
      required Widget childWidget}){

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft:  Radius.circular(topBorderRadius),
          topRight: Radius.circular(topBorderRadius)),
    ),
    // clipBehavior: Clip.antiAliasWithSaveLayer,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        // initialChildSize: 0.65,
        maxChildSize: bottomSheetHeight,
        initialChildSize: bottomSheetHeight,
        expand: false,
        builder: (context, scrollController) {
          return childWidget;
        },
      );
    },
  );
}