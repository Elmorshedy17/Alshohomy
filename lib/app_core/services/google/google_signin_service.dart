// import 'package:google_sign_in/google_sign_in.dart';
//
// class GoogleSignInService {
//   ///////////////////////////////////////////////////////
//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: [
//       'profile',
//       'email',
//     ],
//   );
//
//   GoogleSignIn get googleSignIn => _googleSignIn;
//   //////////////////////////////////////////////////////
//   GoogleSignInAccount? _signInAccount;
//   GoogleSignInAccount? get signInAccount => _signInAccount;
//   //  set signInAccount(account) => _signInAccount = account;
//
//   ////////////////////////////////////////////////////////
//   Future<void> signIn() async {
//     try {
//       print('I am here Google signin Service');
//       await _googleSignIn.signIn().then((value) => _signInAccount = value);
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   ///////////////////////////////////////////////////////
//   Future<void> signOut() async {
//     try {
//       await _googleSignIn.disconnect().then((value) => _signInAccount = value);
//     } catch (e) {
//       print(e);
//     }
//   }
// ///////////////////////////////////////////////////////
// }
