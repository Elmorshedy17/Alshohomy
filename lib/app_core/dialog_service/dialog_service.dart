import 'dart:async';

import '../app_core.dart';

class DialogService {
  // Function(AlertRequest) _showDialogListener;
  // Map<String, Function(DialogRequest)> _showDialogListener =
  //     Map<String, Function(DialogRequest)>();

  late Completer<DialogResponse> _dialogCompleter;

  Map<String, Function(DialogRequest)> _dialogs =
      Map<String, Function(DialogRequest)>();

  /// Registers a callback function. Typically to show the dialog
  void registerDialogs(String name, Function(DialogRequest) dialogBuilder) {
    _dialogs['$name'] = dialogBuilder;
    // _showDialogListener['$name'] = _dialogs['$name'];
  }

  // fetch(String name) => _dialogs['name'];

  /// Registers a callback function. Typically to show the dialog
  // void registerDialogListener(Function(AlertRequest) showDialogListener) {
  //   _showDialogListener = showDialogListener;
  // }

  /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
  Future<DialogResponse> showDialog(
    String name,
    DialogRequest request,
    // {
    // String title,
    // String description,
    // String okBtnTitle = 'Ok',
    // String cancelBtnTitle = 'Cancel',
    // bool barrierDismissible = false,
    // }
  ) {
    _dialogCompleter = Completer<DialogResponse>();

    _dialogs['$name']!.call(request
        // DialogRequest(
        //   title: title,
        //   description: description,
        //   // okBtnTitle: okBtnTitle,
        //   // cancelBtnTitle: cancelBtnTitle,
        // ),
        );
    return _dialogCompleter.future;
  }

  // Future<DialogResponse> showDialog2({
  //   String title,
  //   String description,
  //   String okBtnTitle = 'Ok',
  //   String cancelBtnTitle = 'Cancel',
  //   // bool barrierDismissible = false,
  // }) {
  //   _dialogCompleter = Completer<DialogResponse>();

  //   // fetch('3').call(AlertRequest(
  //   //   title: title,
  //   //   description: description,
  //   //   okBtnTitle: okBtnTitle,
  //   //   cancelBtnTitle: cancelBtnTitle,
  //   // ));
  //   _dialogs['name'].call(
  //     DialogRequest(
  //       title: title,
  //       description: description,
  //       okBtnTitle: okBtnTitle,
  //       cancelBtnTitle: cancelBtnTitle,
  //     ),
  //   );
  //   return _dialogCompleter.future;
  // }
  // Future<AlertResponse> showDialog2({
  //   String title,
  //   String description,
  //   String okBtnTitle = 'Ok',
  //   String cancelBtnTitle = 'Cancel',
  //   bool barrierDismissible = false,
  // }) {
  //   _dialogCompleter = Completer<AlertResponse>();
  //   _showDialogListener(
  //     AlertRequest(
  //       title: title,
  //       description: description,
  //       okBtnTitle: okBtnTitle,
  //       cancelBtnTitle: cancelBtnTitle,
  //     ),
  //   );
  //   return _dialogCompleter.future;
  // }

  /// Completes the _dialogCompleter to resume the Future's execution call
  void dialogComplete(DialogResponse alertResponse) {
    _dialogCompleter.complete(alertResponse);
    // _dialogCompleter = null;
  }
}
