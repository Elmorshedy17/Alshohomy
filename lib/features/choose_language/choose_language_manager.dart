import 'package:flutter/foundation.dart';

class ChooseLanguageManager {
  final ValueNotifier<int> _selectionNotifier = ValueNotifier(-1);
  set inSelected(int newValue) => _selectionNotifier.value = newValue;
  ValueNotifier<int> get notifier => _selectionNotifier;
  int get selectedIndex => _selectionNotifier.value;
}
