// ignore_for_file: file_names

import 'package:comcer_app/core/app_colors.dart';
import 'package:flutter/material.dart';

class TableCard extends StatelessWidget {
  final String number;
  final VoidCallback onTap;


  const TableCard(
      {Key? key,
        required this.number,
        required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(color: AppColors.darkRed),
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'MESA',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14
              ),
            ),
            Text(
              number,
              style: TextStyle(
                  color: AppColors.darkRed,
                  fontWeight: FontWeight.bold,
                  fontSize: 40
              ),
            ),
          ],
        ),
      ),
    );

  }
}
