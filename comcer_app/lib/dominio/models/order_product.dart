import 'package:comcer_app/dominio/models/Product.dart';
import 'package:flutter/material.dart';

class OrderProduct extends ChangeNotifier {
  //Atributos do OrderProduct
  int? _id;
  late Product _product;
  late int _quantidade;
  late double _valorUnitario;
  late int _status;
  String? _dataHoraPedido;

  OrderProduct.empty();

  OrderProduct(
    this._product,
    this._quantidade,
    this._valorUnitario,
    this._status,
    this._dataHoraPedido,
  );

  OrderProduct.fromProduto(this._product) {
    quantidade = 1;
    valorUnitario = produto.preco;
    status = 0;
  }

  //Getters and Setters
  int? get id => _id;

  set id(int? value) {
    _id = value;
  }

  Product get produto => _product;

  set produto(Product value) {
    _product = value;
  }

  int get quantidade => _quantidade;

  set quantidade(int value) {
    _quantidade = value;
  }

  double get valorUnitario => _valorUnitario;

  set valorUnitario(double value) {
    _valorUnitario = value;
  }

  int get status => _status;

  set status(int value) {
    _status = value;
  }

  String? get dataHoraPedido => _dataHoraPedido;

  set dataHoraPedido(String? value) {
    _dataHoraPedido = value;
  }

  double get precoTotal => valorUnitario * quantidade;

  //Converter JSON para classe
  OrderProduct.fromJson(Map<String, dynamic> json) {
    _id = json["id"].toInt();
    _product =
        ((json["produto"] != null) ? Product.fromJson(json["produto"]) : null)!;
    _quantidade = json["quantidade"].toInt();
    _valorUnitario = json["valorUnitario"].toDouble();
    _status = json["status"].toInt();
    _dataHoraPedido = json["dataHoraPedido"].toString();
  }

  //Converter classe para JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = _id;
    if (_product != null) {
      data["produto"] = _product.toJson();
    }
    data["quantidade"] = _quantidade;
    data["valorUnitario"] = _valorUnitario;
    data["status"] = _status;
    data["dataHoraPedido"] = _dataHoraPedido;
    return data;
  }

  bool isEqual(Product product) {
    return product == produto;
  }

  void increment() {
    quantidade++;
    notifyListeners();
  }

  void decrement() {
    quantidade--;
    notifyListeners();
  }
}
