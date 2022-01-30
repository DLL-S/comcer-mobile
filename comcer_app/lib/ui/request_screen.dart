import 'package:comcer_app/controller/product_controller.dart';
import 'package:comcer_app/core/app_colors.dart';
import 'package:comcer_app/dominio/models/response_API/ApiResponse.dart';
import 'package:comcer_app/dominio/models/Product.dart';
import 'package:comcer_app/dominio/models/response_API/product_response_api.dart';
import 'package:flutter/material.dart';

import 'components/card/order_in_progress_card/OrderCard.dart';

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
