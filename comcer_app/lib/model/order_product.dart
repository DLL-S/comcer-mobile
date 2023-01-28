import 'package:comcer_app/model/product.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';


part 'order_product.g.dart';

@JsonSerializable()
class OrderProduct extends ChangeNotifier {
  int? id;
  late Product product;
  late int quantidade;
  late double valorUnitario;
  late int status;
  String? dataHoraPedido;

  OrderProduct.empty();

  OrderProduct({
    required this.product,
    required this.quantidade,
    required this.valorUnitario,
    required this.status,
    this.dataHoraPedido,
    }
  );

  OrderProduct.fromProduto(this.product) {
    quantidade = 1;
    valorUnitario = product.preco;
    status = 0;
  }

  double get precoTotal => valorUnitario * quantidade;

  bool isEqual(Product product) {
    return this.product == product;
  }

  void increment() {
    quantidade++;
    notifyListeners();
  }

  void decrement() {
    quantidade--;
    notifyListeners();
  }

  factory OrderProduct.fromJson(Map<String,dynamic> json) => _$OrderProductFromJson(json);

  Map<String,dynamic> toJson() => _$OrderProductToJson(this);
}
