// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:shahowmy/app_core/app_core.dart';
// import 'package:shahowmy/app_core/resources/app_assets/app_assets.dart';
// import 'package:shahowmy/app_core/resources/app_strings/app_strings.dart';
// import 'package:shahowmy/app_core/resources/app_style/app_style.dart';
// import 'package:shahowmy/features/choose_language/choose_language_manager.dart';
// import 'package:shahowmy/features/choose_language/language_data.dart';
// import 'package:shahowmy/features/testing_text_filed/test_text_filed_page.dart';
// import 'package:shahowmy/shared/selection_widget/selection_widget.dart';
//
// class ChooseLanguagePage extends StatelessWidget {
//   const ChooseLanguagePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final appLanguageManager = context.use<AppLanguageManager>();
//     final chooseLanguageManager = context.use<ChooseLanguageManager>();
//     final langList = [
//       LanguageData(
//           svgImage: AppAssets.english,
//           title: '${context.translate(AppStrings.sEnglish)}'),
//       LanguageData(
//           svgImage: AppAssets.arabic,
//           title: '${context.translate(AppStrings.sArabic)}'),
//     ];
//     return Scaffold(
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(
//                 height: 100,
//               ),
//               BounceInDown(
//                 duration: const Duration(seconds: 2),
//                 child: Pulse(
//                   duration: const Duration(seconds: 4),
//                   child: SizedBox(
//                     height: 130.w,
//                     width: 200.w,
//                     child: SvgPicture.asset(
//                       AppAssets.appLogo,
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 90,
//               ),
//               FadeInLeft(
//                 duration: const Duration(seconds: 1),
//                 child: Pulse(
//                   duration: const Duration(seconds: 2),
//                   child: Text(
//                     '${context.translate(AppStrings.sLanguages)}',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 20.sp,
//                       color: Colors.black,
//                       height: 1.3,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               FadeInRight(
//                 duration: const Duration(seconds: 1),
//                 child: Pulse(
//                   duration: const Duration(seconds: 2),
//                   child: Text(
//                     '${context.translate(AppStrings.sLanguagesMsg)}',
//                     style: TextStyle(
//                       fontSize: 13.sp,
//                       color: Colors.grey,
//                       height: 1.3,
//                     ),
//                   ),
//                 ),
//               ),
//               FadeInLeft(
//                 duration: const Duration(seconds: 2),
//                 child: ListView.separated(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: langList.length,
//                   separatorBuilder: (_, index) => const SizedBox(height: 20),
//                   itemBuilder: (_, index) => ValueListenableBuilder<int>(
//                       valueListenable: chooseLanguageManager.notifier,
//                       builder: (context, value, _) {
//                         return InkWell(
//                           onTap: () {
//                             chooseLanguageManager.inSelected = index;
//                             index == 0
//                                 ? appLanguageManager
//                                     .changeLanguage(const Locale('en'))
//                                 : appLanguageManager
//                                     .changeLanguage(const Locale('ar'));
//                           },
//                           child: SelectionWidget(
//                             isSelected: index == value,
//                             title: langList[index].title,
//                             svgImagePath: langList[index].svgImage,
//                           ),
//                         );
//                       }),
//                 ),
//               ),
//               FadeInRight(
//                 duration: const Duration(seconds: 2),
//                 child: Container(
//                   height: 55,
//                   padding: const EdgeInsets.symmetric(horizontal: 0),
//                   margin: const EdgeInsets.only(bottom: 25),
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       primary: AppStyle.brown,
//                       shadowColor: AppStyle.brown,
//                       fixedSize:
//                           Size.fromWidth(MediaQuery.of(context).size.width),
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                     ),
//                     child: Text(
//                       '${context.translate(AppStrings.sContinue)}',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w300,
//                         height: 1.3,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     onPressed: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => TestTextFiledPage(),
//                       ));
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
