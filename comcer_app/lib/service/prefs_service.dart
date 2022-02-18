import 'dart:convert';

import 'package:comcer_app/dominio/models/User.dart';
import 'package:comcer_app/util/util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService extends ChangeNotifier {

  bool loading = false;

  static const String _key = 'user_credential';


  void setLoading(bool value){
    loading = value;
    notifyListeners();
  }

  Future<void> saveLogIn(User user) async {
    setLoading(true);
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(_key, jsonEncode({
      "user": user.email,
      "token": user.token,
      "role": user.role,
      "isAuth": true
    }));
    setLoading(false);
  }

  static Future<bool> isAuth() async {
    var prefs = await SharedPreferences.getInstance();

    var jsonResult = prefs.get(_key);

    if(jsonResult != null) {
      var mapUser = jsonDecode(jsonResult as String);
      return mapUser['isAuth'];
    }
    return false;
  }



  static Future<void> logout() async {
    var prefs = await SharedPreferences.getInstance();
    Util.removeToken();
    await prefs.remove(_key);
  }

}
