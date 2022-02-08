import 'package:comcer_app/core/app_colors.dart';
import 'package:flutter/material.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {



  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightRed,
    );
  }
}


// ListView(
//   shrinkWrap: true,
//   scrollDirection: Axis.vertical,
//   children: [
//     OrderCard()
//   ],
// ),
