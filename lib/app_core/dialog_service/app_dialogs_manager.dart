// import 'dart:async';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// import '../app_core.dart';
// import 'dialog_service.dart';

// class DialogsManager {
//   DialogService _dialogService = locator<DialogService>();
//   NavigationService _navigationService = locator<NavigationService>();
//   // BuildContext _context;
//   // set context(BuildContext context) => _context = context;

//   bool _confirmationResult;
//   bool get confirmationResult => _confirmationResult;

//   bool isDialogShown;

//   DialogResponse _dialogResponse;
//   DialogResponse get customDialogResult => _dialogResponse;

//   Future showDialog(String name, DialogRequest request) async {
//     print('dialog shown');
//     isDialogShown = true;
//     var dialogResult = await _dialogService.showDialog(name, request
//         //   title: 'Dialog Manager 1111111', description: 'Test Test 1111111'
//         );

//     if (dialogResult.isConfirmed == null) {
//       isDialogShown = false;
//     } else {
//       if (dialogResult.isConfirmed) {
//         print('$name');
//         print('User has confirmed');
//         _confirmationResult = true;
//         Navigator.of(_navigationService.dialogContext).pop();
//         isDialogShown = false;
//       } else {
//         _confirmationResult = false;
//         Navigator.of(_navigationService.dialogContext).pop();
//         isDialogShown = false;

//         print('User cancelled the dialog');
//       }
//     }
//   }

//   // Future errorDialog(String name) async {
//   //   print('dialog shown');
//   //   var dialogResult = await _dialogService.showDialog(name,
//   //       title: 'Dialog Manager 2222', description: 'Test Test 2222');

//   //   if (dialogResult.isConfirmed) {
//   //     print('$name');
//   //     print('User has confirmed');
//   //     _confirmationResult = true;
//   //   } else {
//   //     _confirmationResult = false;
//   //     print('User cancelled the dialog');
//   //   }
//   // }

//   // Future showBasicDialog2() async {
//   //   print('dialog shown');
//   //   var dialogResult = await _dialogService.showDialog2(
//   //       title: 'Dialog Manager 2222222222222',
//   //       description: 'Test Test 22222222222');

//   //   if (dialogResult.isConfirmed) {
//   //     print('User has confirmed');
//   //     _confirmationResult = true;
//   //   } else {
//   //     _confirmationResult = false;
//   //     print('User cancelled the dialog');
//   //   }
//   // }

//   // Future retry(RequestOptions requestOptions) async {
//   //   print('dialog called');
//   //   var dialogResult =
//   //       await _dialogService.showDialog(title: 'Error', description: 'Something went wrong please retry again.');

//   //   print('dialog closed');

//   //   if (dialogResult.confirmed) {
//   //     if (ModalRoute.of(_context).settings.name != '/SignInPage' ||
//   //         ModalRoute.of(_context).settings.name != '/SignUpPage') {
//   //       recallService(requestOptions);
//   //     } else {
//   //       locator<LoadingManager>().inLoading.add(false);
//   //     }
//   //     print('User has confirmed');
//   //   } else {
//   //     print('User has cancelled the dialog');
//   //   }
//   // }

//   // Future<Response> recallService(RequestOptions requestOptions) async {
//   //   final responseCompleter = Completer<Response>();

//   //   // Complete the completer instead of returning
//   //   responseCompleter.complete(
//   //     locator<ApiService>().dioClient.request(
//   //           requestOptions.path,
//   //           cancelToken: requestOptions.cancelToken,
//   //           data: requestOptions.data,
//   //           onReceiveProgress: requestOptions.onReceiveProgress,
//   //           onSendProgress: requestOptions.onSendProgress,
//   //           queryParameters: requestOptions.queryParameters,
//   //           options: requestOptions,
//   //         ),
//   //   );

//   //   return responseCompleter.future;
//   // }
// }
