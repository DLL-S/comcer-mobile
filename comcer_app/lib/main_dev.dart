import 'dart:io';
import 'package:comcer_app/Environment_config.dart';
import 'package:comcer_app/dominio/enum/environment.dart';
import 'core/app_widget.dart';
import 'package:flutter/material.dart';
import 'dominio/models/my_http_overrides.dart';

void main(){
  EnvironmentConfig.environmentBuild = Environments.DESENVOLVIMENTO;
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  HttpOverrides.global = MyHttpOverrides();
  runApp(AppWidget());
}
