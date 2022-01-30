// ignore_for_file: file_names

import 'dart:ffi';

class Product {

  late int _id;
  late String _nome;
  late String _descricao;
  late double _preco;
  late String _foto;

  //Construtor default
  Product.vazio();

  //Construtor
  Product(
      this._id,
      this._nome,
      this._descricao,
      this._preco,
      this._foto
      );

  //Getters and Setters
  int get id => _id;
  set id(int value) {
    _id = value;
  }

  String get nome => _nome;
  set nome(String value) {
    _nome = value;
  }

  String get descricao => _descricao;
  set descricao(String value) {
    _descricao = value;
  }

  double get preco => _preco;
  set preco(double value) {
    _preco = value;
  }

  String get foto => _foto;
  set foto(String value) {
    _foto = value;
  }

  //Converter JSON para classe
  Product.fromJson(Map<String, dynamic> json) {
    _id = json["id"].toInt();
    _nome = json["nome"].toString();
    _descricao = json["descricao"].toString();
    _preco = json["preco"].toDouble();
    _foto = json["foto"].toString();
  }

  //Converter classe para JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = _id;
    data["nome"] = _nome;
    data["descricao"] = _descricao;
    data["preco"] = _preco;
    data["foto"] = _foto;
    return data;
  }


}
