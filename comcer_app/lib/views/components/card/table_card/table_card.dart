import 'package:comcer_app/design/core.dart';
import 'package:comcer_app/util/constants.dart';
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
            border: const Border.fromBorderSide(
              BorderSide(color: CCColors.darkRed),
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
                    color: status ? CCColors.green : CCColors.red,
                    shape: BoxShape.circle),
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
                  Constant.mesaUpperCase,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                Text(
                  number.toString(),
                  style: const TextStyle(
                      color: CCColors.darkRed,
                      fontWeight: FontWeight.bold,
                      fontSize: 35),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
