// ignore_for_file: file_names

import 'package:comcer_app/core/app_colors.dart';
import 'package:flutter/material.dart';

class TableCard extends StatelessWidget {
  final int number;
  final bool status;
  final VoidCallback onTap;


  const TableCard(
      {Key? key,
        required this.number,
        required this.status,
        required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(bottom: 16, top: 8, right: 8, left: 8),
        decoration: BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(color: AppColors.darkRed),
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Container(
              width: 100,
              alignment: Alignment.topRight,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    color: status ? AppColors.green : AppColors.red,
                    shape: BoxShape.circle
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
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
                  number.toString(),
                  style: TextStyle(
                      color: AppColors.darkRed,
                      fontWeight: FontWeight.bold,
                      fontSize: 35
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );

  }
}
