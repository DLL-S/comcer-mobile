// ignore_for_file: file_names

import 'package:comcer_app/core/app_cores.dart';
import 'package:flutter/material.dart';

class FilterCard extends StatefulWidget {
  final String filtro;
  final Color cor;
  late bool tap;
  final VoidCallback onTap;


  FilterCard(
      {Key? key,
        required this.filtro,
        required this.cor,
        required this.tap,
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
        widget.tap = !widget.tap;
      });},
      child: Container(
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(color: widget.cor),
            ),
            color: widget.tap ? widget.cor: Colors.white,
            borderRadius: BorderRadius.circular(50)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.filtro,
              style: TextStyle(
                  color: widget.tap ? Colors.white : widget.cor,
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
