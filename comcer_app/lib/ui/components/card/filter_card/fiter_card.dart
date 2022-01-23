// ignore_for_file: file_names

import 'package:flutter/material.dart';

class FilterCard extends StatefulWidget {
  late String filter;
  late Color color;
  late bool isTapped;
  late VoidCallback onTap;


  FilterCard(
      {Key? key,
        required this.filter,
        required this.color,
        required this.isTapped,
        required this.onTap})
      : super(key: key);

  @override
  State<FilterCard> createState() => _FilterCardState();
}

class _FilterCardState extends State<FilterCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){setState(() {
        widget.isTapped = !widget.isTapped;
      });},
      child: Container(
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(color: widget.color),
            ),
            color: widget.isTapped ? widget.color: Colors.white,
            borderRadius: BorderRadius.circular(50)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.filter,
              style: TextStyle(
                  color: widget.isTapped ? Colors.white : widget.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 14
              ),
            ),
          ],
        )
      ),
    );

  }
}
