import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class NotAvailableComponent extends StatelessWidget {
  final String? title;
  final String? desc;
  final Widget? view;
  final TextStyle? titleTextStyle;
  final TextStyle? descTextStyle;

  const NotAvailableComponent({
    Key? key,
    this.title,
    this.desc,
    this.view,
    this.titleTextStyle = const TextStyle(
        color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
    this.descTextStyle = const TextStyle(
        color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 25),
        children: [
          Center(
            child: FadeInDown(
              child: ZoomIn(child: view == null ? Container() : view!),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          title == null
              ? Container()
              : FadeInRightBig(
                  child: Center(
                      child: Text(
                  '$title',
                  style: titleTextStyle,
                  textAlign: TextAlign.center,
                ))),
          const SizedBox(
            height: 15,
          ),
          desc == null
              ? Container()
              : FadeInLeftBig(
                  child: Center(
                    child: Text(
                      '$desc',
                      style: descTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
