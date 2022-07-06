import 'dart:io';

import 'package:comcer_app/environment_config.dart';
import 'package:comcer_app/dominio/enum/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/app_widget.dart';
import 'dominio/models/my_http_overrides.dart';

void main() {
  EnvironmentConfig.environmentBuild = Environments.PRODUCAO;
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  HttpOverrides.global = MyHttpOverrides();
  runApp(AppWidget());
}
