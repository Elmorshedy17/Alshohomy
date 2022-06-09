import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shahowmy_app/app_core/resources/app_style/app_style.dart';
import 'package:shahowmy_app/shared/network_app_image/network_app_image.dart';

class SelectionWidget extends StatelessWidget {
  final bool isSelected,hasBorder;
  final String title;
  final String? svgImagePath;
  final double imgNetWorkBorderRadius;
  const SelectionWidget(
      {Key? key,
      this.isSelected = false,
      required this.title,
      this.hasBorder = true,
      this.imgNetWorkBorderRadius = 0,
      this.svgImagePath,
     })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        border: Border.all(
          color: hasBorder ?( isSelected ? AppStyle.oil : Colors.grey[400]!):Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          // if (imgNetWorkUrl != null ) ClipRRect(
          //     borderRadius: BorderRadius.circular(imgNetWorkBorderRadius),
          //     child: NetworkAppImage(imageUrl: "$imgNetWorkUrl",height: 20,width: 20,boxFit: BoxFit.fill,errorWidget: Icon(Icons.flag,color: AppStyle.lightGrey,),)),
          // if (imgNetWorkUrl != null ) const SizedBox(
          //   width: 15,
          // ),
          if (svgImagePath != null) SvgPicture.asset(svgImagePath!),
          if (svgImagePath != null)
            const SizedBox(
              width: 15,
            ),
          Container(
            padding: const EdgeInsets.all(3),
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              color: isSelected ? AppStyle.oil.withOpacity(.3) : AppStyle.appColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              border: Border.all(color: Colors.grey[400]!),
            ),
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: isSelected ? AppStyle.oil : AppStyle.lightGrey,
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
                border: Border.all(color: isSelected ? AppStyle.oil : AppStyle.lightGrey),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              color: isSelected ? Colors.black : Colors.grey,
              height: 1.3,
            ),
          ),

        ],
      ),
    );
  }
}
