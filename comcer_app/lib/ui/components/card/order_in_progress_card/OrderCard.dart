// ignore_for_file: file_names


import 'package:comcer_app/core/app_colors.dart';
import 'package:comcer_app/core/app_styles.dart';
import 'package:comcer_app/util/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  // final String number;
  // final VoidCallback onTap;


  /*const OrderCard(
      {Key? key,
        required this.number,
        required this.onTap})
      : super(key: key);*/

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(color: AppColors.darkRed),
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const Text(
                  'MESA',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                ),
                Text(
                  '11',
                  style: TextStyle(
                      color: AppColors.darkRed,
                      fontWeight: FontWeight.bold,
                      fontSize: 45
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Pedido n. ',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),
                    ),
                    Text(
                      '0000000',
                      style: TextStyle(
                          color: AppColors.darkRed,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),

              ],
            ),
          ],
        ),
      ),
    );

  }
}
