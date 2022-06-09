import 'package:flutter/material.dart';
import 'package:shahowmy_app/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:shahowmy_app/app_core/resources/app_style/app_style.dart';

class MainButtonWidget extends StatelessWidget {
  final double? width;
  final Color? color, shadowColor;
  final String title;
  final VoidCallback? onClick;

  const MainButtonWidget({
    Key? key,
    this.width,
    this.color,
    this.shadowColor,
    required this.title,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      margin: const EdgeInsets.only(bottom: 25),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          primary: color ?? AppStyle.oil,
          shadowColor: shadowColor ?? AppStyle.oil,
          fixedSize: Size.fromWidth(width ?? MediaQuery.of(context).size.width),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(
          title,
          style: AppFontStyle.whitMedStyle,
          textAlign: TextAlign.center,
        ),
        onPressed: onClick,
      ),
    );
  }
}
