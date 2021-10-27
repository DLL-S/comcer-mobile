import 'package:comcer_app/core/app_cores.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

class AppGradientes {
  static final linear = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
    AppCores.red,
    AppCores.darkRed,
  ],);
}
