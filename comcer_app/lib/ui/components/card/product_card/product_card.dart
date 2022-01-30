import 'dart:convert';

import 'package:comcer_app/core/core.dart';
import 'package:comcer_app/dominio/models/Product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {

  final Product produto;

  const ProductCard({Key? key, required this.produto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(color: AppColors.darkRed),
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 60,
              width: 90,
              child: Image.memory(base64Decode(produto.foto), fit: BoxFit.contain,),
            )
          ],
        ),
      ),
    );
  }
}
