import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../app_core.dart';

class AppLanguageManager extends Manager {
  final BehaviorSubject<Locale> _localSubject =
      BehaviorSubject.seeded(const Locale('en'));
  Stream<Locale> get locale$ => _localSubject.stream;
  Sink<Locale> get inLocale => _localSubject.sink;
  Locale get currentLocale => _localSubject.value;

  fetchLocale() async {
    var prefs = locator<PrefsService>();
    if (prefs.appLanguage.isEmpty) {
      inLocale.add(const Locale('en'));
      return;
    }
    inLocale.add(Locale(prefs.appLanguage));
    return;
  }

  void changeLanguage(Locale locale) async {
    var prefs = locator<PrefsService>();
    if (currentLocale == locale) {
      return;
    }
    if (locale == const Locale("ar")) {
      prefs.appLanguage = 'ar';
      inLocale.add(const Locale("ar"));
    } else {
      prefs.appLanguage = 'en';
      inLocale.add(const Locale("en"));
    }
  }

  @override
  void dispose() {
    _localSubject.close();
  }

  @override
  void clearSubject() {
    // TODO: implement clearSubject
  }
}
