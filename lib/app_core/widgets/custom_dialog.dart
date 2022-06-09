import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shahowmy_app/app_core/app_core.dart';
import 'package:shahowmy_app/app_core/resources/app_style/app_style.dart';

///////////////////////////////////////////////////////////////////////////////
/// Custom alert dialog.
/// ///////////////////////////////////////////////////////////////////////////
class CustomDialog extends StatelessWidget {
  final String? title,
      description,
      confirmBtnTxt,
      cancelBtnTxt,
      imageUrl,
      imageInBodyUrl;
  final VoidCallback? onClickConfirmBtn, onClickCancelBtn, onCloseBtn;
  final Color? titleColor, descriptionColor, confirmBtnColor, cancelBtnColor;
  final bool? hasCloseBtn;
  final Widget? extraWidget;

  const CustomDialog({
    this.title,
    this.description,
    this.confirmBtnTxt = 'Ok',
    this.cancelBtnTxt = 'Cancel',
    this.imageUrl,
    this.onClickConfirmBtn,
    this.onClickCancelBtn,
    this.titleColor = Colors.black,
    this.descriptionColor = Colors.black,
    this.confirmBtnColor = Colors.grey,
    this.cancelBtnColor = Colors.grey,
    this.imageInBodyUrl,
    this.hasCloseBtn = false,
    this.onCloseBtn,
    this.extraWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    // ScreenUtil.init(context);

    final prefs = context.use<PrefsService>();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: imageUrl != null
                  ? 100
                  : onCloseBtn != null
                      ? 20
                      : 40,
              bottom: 16,
              left: 16,
              right: 16,
            ),
            margin: const EdgeInsets.only(
              top: 16,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(17),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                imageInBodyUrl != null
                    ? BounceInUp(
                        delay: const Duration(milliseconds: 200),
                        child: Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 40),
                          width: 80,
                          height: 80,
                          child: Image.asset(imageInBodyUrl!),
                        ),
                      )
                    : Container(),
                onCloseBtn != null
                    ? Align(
                        alignment: prefs.appLanguage == 'en'
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                            size: 35,
                          ),
                          onPressed: onCloseBtn,
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: onCloseBtn != null ? 7 : 0,
                ),
                title != null
                    ? Text(
                        title!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w700,
                            color: titleColor,
                            height: 1.3),
                      )
                    : Container(),
                SizedBox(
                  height: title != null ? 20 : 0,
                ),
                description != null
                    ? Text(
                        description!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: descriptionColor,
                            height: 1.3),
                      )
                    : Container(),
                SizedBox(
                  height: description != null ? 50 : 0,
                ),
                extraWidget ?? Container(),
                // extraWidget != null ? extraWidget : Container(),
                SizedBox(
                  height: extraWidget != null ? 40 : 0,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FittedBox(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 55,
                          width: onClickCancelBtn != null
                              ? null
                              : MediaQuery.of(context).size.width * 0.60,
                          child: RaisedButton(
                            color: confirmBtnColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side:  BorderSide(color: AppStyle.oil),
                            ),
                            child: Text(
                              confirmBtnTxt!,
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.white,
                                  height: 1.3),
                            ),
                            onPressed: onClickConfirmBtn,
                          ),
                        ),
                        SizedBox(
                          width: onClickCancelBtn != null ? 50 : 0,
                        ),
                        onClickCancelBtn != null
                            ? SizedBox(
                                height: 55,
                                child: RaisedButton(
                                  color: cancelBtnColor,
                                  child: Text(
                                    cancelBtnTxt!,
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.white,
                                        height: 1.3),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: onClickCancelBtn,
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 16,
            right: 16,
            child: imageUrl != null
                ? CircleAvatar(
                    // backgroundColor: Colors.white,
                    // foregroundColor: Colors.white,
                    // backgroundImage: AssetImage(imageUrl),
                    radius: 50,
                    child: ClipOval(
                      child: Image.asset(
                        imageUrl!,
                        // fit: BoxFit.fill,
                      ),
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
