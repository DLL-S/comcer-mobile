// ignore_for_file: file_names

import 'package:comcer_app/core/app_cores.dart';
import 'package:flutter/material.dart';

class TableCard extends StatelessWidget {
  final String numero;
  final VoidCallback onTap;


  const TableCard(
      {Key? key,
        required this.numero,
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
              BorderSide(color: AppCores.darkRed),
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
              numero,
              style: TextStyle(
                  color: AppCores.darkRed,
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
