import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shahowmy_app/app_core/app_core.dart';
import 'package:shahowmy_app/app_core/resources/app_assets/app_assets.dart';
import 'package:shahowmy_app/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:shahowmy_app/app_core/resources/app_style/app_style.dart';
import 'package:rxdart/rxdart.dart';


class CustomTextFiledObscureText extends StatelessWidget {

  final BehaviorSubject<TextFiledBool> _subject =
  BehaviorSubject<TextFiledBool>();

  // bool ;

  var validationBool;
  // bool isError = false;
  String?  validationErrorMessage;
  final prefs = locator<PrefsService>();
  final FocusNode? currentFocus;
  final bool? isTextArea,hasBorder,shouldPrefixDataLocal,shouldSuffixDataLocal;

  // final bool? obscureText;
  // final bool? isTextArea;
  // final bool hasBorder;
  final int? maxLines;
  final ValueChanged<String>? onFieldSubmitted;
  // final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final String? labelText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final fillColor;
  final hintText;
  final initialValue;
  final int? maxLength;
  // FocusNode nextFocus;

  CustomTextFiledObscureText(

      {this.currentFocus,
        this.isTextArea = false,
        this.hasBorder = true,
        this.validationErrorMessage = "",
        // this.obscureText = true,
        // this.isFillColorError = false,
        this.maxLines,
        this.onFieldSubmitted,
        // this.validator,
        this.onChanged,
        this.keyboardType,
        this.prefixIcon,
        this.suffixIcon,
        this.labelText,
        this.controller,
        this.validationBool,
        this.fillColor,
        this.hintText,
        this.initialValue,
        this.maxLength,
        this.shouldPrefixDataLocal = true,
        this.shouldSuffixDataLocal = true
        // this.nextFocus,

      });

  bool obscureText = true;
  bool isFillColorError = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TextFiledBool>(
        initialData: TextFiledBool(isFillColorError: isFillColorError,obscureText: obscureText),
        stream: _subject.stream,
        builder: (context, snapshot) {
          return TextFormField(
            maxLength: maxLength,
            initialValue: initialValue,
            controller: controller,
            focusNode: currentFocus,
            obscureText: obscureText,
            maxLines: maxLines,
            scrollPhysics:const BouncingScrollPhysics(),
            onFieldSubmitted: onFieldSubmitted,
            validator: (validator) {

              if(validationBool != null){
                if(validationBool(validator)){
                  isFillColorError = true;
                  _subject.sink.add(TextFiledBool(isFillColorError: isFillColorError,obscureText: obscureText));
                  validationErrorMessage;
                  print(validationErrorMessage);

                  return "$validationErrorMessage";

                }else{
                  // isError = false;
                  // _subject.sink.add(TextFiledBool(isFillColorError: false));
                  isFillColorError = false;
                  _subject.sink.add(TextFiledBool(isFillColorError: isFillColorError,obscureText: obscureText));
                  // print(isError);
                }
              }


              // if (validator!.isEmpty) {
              //   return "required_str";
              // }
              return null;
            },
            onChanged: onChanged,
            keyboardType: keyboardType,
            decoration: InputDecoration(

                counterText: '',
                errorMaxLines: 3,
                contentPadding: isTextArea == false
                    ?  ( hasBorder == true ? EdgeInsets.symmetric(
                    horizontal: prefixIcon != null ? 0 : 15, vertical: 0):const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0))
                    :const EdgeInsets.all(15),
                // isDense: false,
                focusedBorder: hasBorder == true ?const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  borderSide: BorderSide(
                    color: AppStyle.oil,
                  ),
                ):InputBorder.none,
                errorBorder: hasBorder == true ?const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  borderSide: BorderSide(
                    color: AppStyle.red,
                  ),
                ):InputBorder.none,
                disabledBorder: hasBorder == true ?const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  borderSide: BorderSide(
                    color: AppStyle.lightGrey,
                  ),
                ):InputBorder.none,
                enabledBorder: hasBorder == true ?const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  borderSide: BorderSide(
                    color: AppStyle.lightGrey,
                  ),
                ):InputBorder.none,
                border: hasBorder == true ?const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  borderSide: BorderSide(
                    color: AppStyle.lightGrey,
                  ),
                ):InputBorder.none,
                filled: true,
                prefixIcon: prefixIcon != null
                    ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(
                        prefs.appLanguage == 'en' ?  0 : ( shouldPrefixDataLocal == true ? math.pi : 0)),
                    child: prefixIcon)
                    : null,
                suffixIcon:   InkWell(
                  onTap: (){
                    if(snapshot.data!.obscureText == true){
                      obscureText = false;
                      _subject.sink.add(TextFiledBool(isFillColorError: isFillColorError,obscureText: obscureText));
                    }else{
                      obscureText = true;
                      _subject.sink.add(TextFiledBool(isFillColorError: isFillColorError,obscureText: obscureText));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(
                      snapshot.data!.obscureText == true ? AppAssets.eyeSlash : AppAssets.eye,
                      // color: Colors.brown,
                      height: 15,
                    ),
                  ),
                ),

                labelText: labelText,
                hintText: hintText,
                hintStyle: AppFontStyle.textFiledHintStyle,
                // hintText: hintText
                fillColor: snapshot.data!.isFillColorError == true ? AppStyle.lighterRed:Colors.transparent),
          );
        }
    );
  }
}

class TextFiledBool{
  bool obscureText,isFillColorError;
  TextFiledBool({this.obscureText = false,this.isFillColorError = false});
}