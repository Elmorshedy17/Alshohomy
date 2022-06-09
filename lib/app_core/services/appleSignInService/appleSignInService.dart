//
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
//
// class AppleSignInService {
//   final signInManager = locator<LoginManager>();
//   final _toast = locator<ToastTemplate>();
//   final _prefs = locator<PrefsService>();
//
//   Future<void> appleLogIn(BuildContext context) async {
//     final keyChain = FlutterSecureStorage();
//
//     //Check if Apple SignIn isn available for the device or not
//     if (await SignInWithApple.isAvailable()) {
//       AuthorizationCredentialAppleID result;
//       await SignInWithApple.getAppleIDCredential(scopes: [
//         AppleIDAuthorizationScopes.email,
//         AppleIDAuthorizationScopes.fullName,
//       ]).then((value) async {
//         print("XXXXX is inside apple sign in then ?");
//         result = value;
//         print(result.email);
//         print(result.givenName);
//         if (result.email != null && result.givenName != null) {
//           await keyChain.write(key: "email", value: result.email);
//           await keyChain.write(key: "name", value: result.givenName);
//           await keyChain.write(key: "userId", value: result.userIdentifier);
//         }
//
//         // return value;
//         print('email: ${result.email} \n name: ${result.givenName}');
//         await signInManager.socialLogin(
//           request: SocialLoginRequest(
//             email: result.email ??
//                 await keyChain.read(key: "email") ??
//                 await keyChain.read(key: "userId") ??
//                 '',
//             name: result.givenName ?? await keyChain.read(key: "name"),
//           ),
//         );
//       }).onError((error, stackTrace) {
//         print("XXXXX sign in with apple custom error ==> $error");
//         _toast.show(_prefs.appLanguage == "en"
//             ? "something went wrong , try again later"
//             : "حدث خطآ ما ، برجاء المحاولة لاحقا");
//       });
//     } else {
//       print('Apple SignIn is not available for your device');
//       _toast.show(_prefs.appLanguage == "en"
//           ? 'Apple SignIn is not available for your device'
//           : "تسجيل الدخول بواسطة ابل غير متاح لجهازك");
//     }
//   }
// }
