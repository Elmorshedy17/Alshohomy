import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:shahowmy_app/app_core/resources/app_assets/app_assets.dart';
import 'package:shahowmy_app/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:shahowmy_app/features/login/login_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shahowmy_app/features/login/login_request.dart';
import 'package:shahowmy_app/shared/custom_text_field/custom_text_field.dart';
import 'package:shahowmy_app/shared/main_button/main_button_widget.dart';
import 'package:shahowmy_app/shared/remove_focus/remove_focus.dart';
import 'package:shahowmy_app/shared/text_field_obsecure/text_field_obsecure.dart';
import 'package:shahowmy_app/app_core/app_core.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _fullNameController = TextEditingController();


  final passwordFocus = FocusNode();

  final fullNameFocus = FocusNode();


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;


  @override
  Widget build(BuildContext context) {
    final loginManager = context.use<LoginManager>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: StreamBuilder<ManagerState>(
          initialData: ManagerState.idle,
          stream: loginManager.state$,
          builder: (context, AsyncSnapshot<ManagerState> stateSnapshot) {
            return FormsStateHandling(
              managerState: stateSnapshot.data,
              errorMsg: loginManager.errorDescription,
              onClickCloseErrorBtn: () {
                loginManager.inState.add(ManagerState.idle);
              },
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child:  Column(
                    children: [
                      Form(
                        key: _formKey,
                        autovalidateMode: _autoValidateMode,
                        child: Container(
                          color:  Colors.white,
                          padding:const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30.h,
                              ),
                              FadeInRightBig(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("مرحبا بك مرة اخرى",style: AppFontStyle.hugTitleBoldBlackStyle,),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text("من فضلك ادخل اسم المستخدم وكلمة المرور",style: AppFontStyle.descBigGreyStyle,),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                              FadeInLeftBig(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("اسم المستخدم",style: AppFontStyle.labelGreyStyle,),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextFiled(
                                      currentFocus: fullNameFocus,
                                      controller: _fullNameController,
                                      // obscureText: obscureText,
                                      keyboardType: TextInputType.text,
                                      hintText:
                                      'اسم المستخدم',
                                      maxLines: 1,
                                      onFieldSubmitted: (v) {
                                        FocusScope.of(context)
                                            .requestFocus(passwordFocus);
                                      },
                                      validationBool: (v) {
                                        return (v.length < 3);
                                      },
                                      validationErrorMessage:
                                      'يجب ان لا يقل عدد الاحرف عن ٣',
                                    ),

                                    const SizedBox(
                                      height: 35,
                                    ),
                                    Text("كلمة المرور",style: AppFontStyle.labelGreyStyle,),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextFiledObscureText(
                                      currentFocus: passwordFocus,
                                      controller: _passwordController,
                                      // obscureText: obscureText,
                                      keyboardType: TextInputType.visiblePassword,
                                      hintText:
                                      '*********',
                                      // prefixIcon: Padding(
                                      //   padding: const EdgeInsets.all(15.0),
                                      //   child: SvgPicture.asset(
                                      //     AppAssets.lock,
                                      //     // color: Colors.brown,
                                      //     height: 15,
                                      //   ),
                                      // ),
                                      maxLines: 1,
                                      onFieldSubmitted: (v) {
                                        removeFocus(context);
                                      },
                                      validationBool: (v) {
                                        return (v.length < 3);
                                      },
                                      validationErrorMessage:
                                      'يجب ان لا يقل عدد الاحرف عن ٣',
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 50.h,
                              ),

                              FadeInRightBig(
                                child: MainButtonWidget(
                                  title:
                                  'تسجيل دخول',
                                  onClick: () async {
                                    removeFocus(context);
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                    } else {
                                      setState(() {
                                        _autoValidateMode = AutovalidateMode.always;
                                      });
                                      return;
                                    }


                                    await loginManager.login(
                                      request: LoginRequest(
                                        username: _fullNameController.text,
                                        password: _passwordController.text,
                                      ),
                                    );
                                  },
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(AppAssets.emailBig,height: 90.h,)
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      ),

    );
  }
}
