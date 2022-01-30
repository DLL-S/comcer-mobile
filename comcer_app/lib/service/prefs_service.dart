import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService extends ChangeNotifier {

  bool loading = false;

  static const String _key = 'key';


  void setLoading(bool value){
    loading = value;
    notifyListeners();
  }

  Future<void> saveLogIn(String user) async {
    setLoading(true);
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(_key, jsonEncode({
      "user": user,
      "isAuth": true
    }));
    await Future.delayed(const Duration(seconds: 10));
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
    await prefs.remove(_key);
  }

}
