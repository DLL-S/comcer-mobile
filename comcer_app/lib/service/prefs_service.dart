import 'dart:convert';

import 'package:comcer_app/dominio/models/User.dart';
import 'package:comcer_app/util/util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService extends ChangeNotifier {
  static const String _key = 'user_credential';

  Future<void> saveLogIn(User user) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(
        _key,
        jsonEncode({
          "user": user.usuario,
          "token": user.token,
          "role": user.role,
          "isAuth": true
        }));
  }

  static Future<bool> isAuth() async {
    var prefs = await SharedPreferences.getInstance();

    var jsonResult = prefs.get(_key);

    if (jsonResult != null) {
      var mapUser = jsonDecode(jsonResult as String);
      return mapUser['isAuth'];
    }
  }

  static Future<String> getToken() async {
    var prefs = await SharedPreferences.getInstance();

    var jsonResult = prefs.get(_key);

    if (jsonResult != null) {
      var mapUser = jsonDecode(jsonResult as String);
      return mapUser['token'];
    } else {
      return 'AAAAAAA';
    }
  }

  static Future<void> logout() async {
    var prefs = await SharedPreferences.getInstance();
    Util.removeToken();
    await prefs.remove(_key);
  }
}
