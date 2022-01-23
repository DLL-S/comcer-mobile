import 'package:comcer_app/core/app_colors.dart';
import 'package:comcer_app/core/app_styles.dart';
import 'package:comcer_app/util/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusWidget extends StatelessWidget {
  final Icon icon;
  final Color color;
  late int status;


  StatusWidget({Key? key, required this.icon, required this.color, required this.status}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
