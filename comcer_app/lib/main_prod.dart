import 'dart:io';
import 'package:comcer_app/environment_config.dart';
import 'package:flutter/material.dart';
import 'app_widget.dart';
import 'enum/environment.dart';
import 'model/my_htpp_overrides.dart';

void main() {
  EnvironmentConfig.environmentBuild = Environments.producao;
  HttpOverrides.global = MyHttpOverrides();
  runApp(const AppWidget());
}
