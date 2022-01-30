import 'dart:io';
import 'core/app_widget.dart';
import 'package:flutter/material.dart';

import 'dominio/models/my_http_overrides.dart';

void main(){
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  HttpOverrides.global = MyHttpOverrides();
  runApp(AppWidget());
}
