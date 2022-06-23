import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void removeFocus(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

void removeKeyboard() {
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}

void requestFocus({required BuildContext context,required FocusNode focusNode}) {
  FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.requestFocus(focusNode);
  }
}