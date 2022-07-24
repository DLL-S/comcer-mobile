import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusWidget extends StatelessWidget {
  final Icon icon;
  final Color color;
  late int status;

  StatusWidget(
      {Key? key, required this.icon, required this.color, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
