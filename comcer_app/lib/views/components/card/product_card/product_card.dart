import 'dart:convert';

import 'package:comcer_app/core/core.dart';
import 'package:flutter/material.dart';
import '../../../../model/product.dart';

class ProductCard extends StatelessWidget {
  final Product produto;

  const ProductCard({Key? key, required this.produto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: const Border.fromBorderSide(
              BorderSide(color: AppColors.darkRed),
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 60,
              width: 90,
              child: Image.memory(
                base64Decode(produto.foto),
                fit: BoxFit.contain,
              ),
            )
          ],
        ),
      ),
    );
  }
}
