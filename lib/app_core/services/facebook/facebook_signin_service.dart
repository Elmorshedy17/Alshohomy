//
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//
// import '../../app_core.dart';
//
// class FacebookSignInService {
//   AccessToken? _accessToken;
//
//   final signInManager = locator<LoginManager>();
//   final _toast = locator<ToastTemplate>();
//   final _prefs = locator<PrefsService>();
//
//   Future<void> loginWithFB() async {
//     final LoginResult result = await FacebookAuth.i.login();
//
//     switch (result.status) {
//       case LoginStatus.success:
//         _accessToken = result.accessToken;
//         final data = await FacebookAuth.i.getUserData();
//         // print('${data}');
//         FacebookResponse _facebookUser = FacebookResponse.fromJson(data);
//         print('${_facebookUser.name}');
//         await signInManager.socialLogin(
//           request: SocialLoginRequest(
//             email: _facebookUser.email ?? _facebookUser.id,
//             name: _facebookUser.name ?? '',
//           ),
//         );
//         print('${data}');
//         break;
//
//       case LoginStatus.cancelled:
//         break;
//       case LoginStatus.failed:
//         print('${result.message}');
//         _toast.show(_prefs.appLanguage == "en"
//             ? "something went wrong , try again later"
//             : "حدث خطآ ما ، برجاء المحاولة لاحقا");
//         break;
//       default:
//         break;
//     }
//   }
//
//   Future<void> logout() async {
//     FacebookAuth.i.logOut();
//   }
// }
