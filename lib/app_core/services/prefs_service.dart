// import 'dart:convert';

import 'dart:convert';

import 'package:shahowmy_app/shared/domain/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static PrefsService? _instance;
  static SharedPreferences? _preferences;

  /// Keys
  static const String appLanguageKey = 'language_code';
  static const String USER_OBJ = 'user';

  static Future<PrefsService?> getInstance() async {
    _instance ??= PrefsService();

    _preferences ??= await SharedPreferences.getInstance();

    return _instance;
  }

  dynamic _getFromPrefs(String key) {
    var value = _preferences!.get(key);
    // print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  // updated _saveToDisk function that handles all types
  void _saveToPrefs<T>(String key, T content) {
    // print('(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content');

    if (content is String) {
      _preferences!.setString(key, content);
    } else if (content is bool) {
      _preferences!.setBool(key, content);
    } else if (content is int) {
      _preferences!.setInt(key, content);
    } else if (content is double) {
      _preferences!.setDouble(key, content);
    } else if (content is List<String>) {
      _preferences!.setStringList(key, content);
    }
  }

  // remove from Prefs
  void _removeFromPrefs(String key) {
    _preferences!.remove(key);
  }

  // clear all Prefs
  void clearAllPrefs() {
    _preferences!.clear();
  }

  // getter for App language.
  String get appLanguage => _getFromPrefs(appLanguageKey) ?? '';
  // setter for App language.
  set appLanguage(String value) => _saveToPrefs(appLanguageKey, value);
  /////////////////////////////////////////////////////////////////////////////////
  User? get userObj {
    var userJson = _getFromPrefs(USER_OBJ);
    if (userJson == null) {
      return null;
    }

    return User.fromJson(json.decode(userJson));
  }

  // setter for USER_OBJECT.
  set userObj(User? userToSave) {
    _saveToPrefs(USER_OBJ, json.encode(userToSave?.toJson()));
  }

  // // Remove UserObj
  removeUserObj() => _removeFromPrefs(USER_OBJ);

}
