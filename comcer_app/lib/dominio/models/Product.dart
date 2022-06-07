// ignore_for_file: file_names


import 'package:comcer_app/dominio/models/BaseAPIResponse.dart';

import 'inconsistencia_validacao.dart';

class Product extends BaseAPIResponse {
  late int _id;
  late String _nome;
  late String _descricao;
  late double _preco;
  late String _foto;

  //Construtor default
  Product.empty();

  //Construtor
  Product(this._id, this._nome, this._descricao, this._preco, this._foto);

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

  Product.fromJsonResponse(Map<String, dynamic> json) {
    if (json['resultados'] != null) {
      resultados = <Product>[];
      json['resultados'].forEach((produto) {
        resultados!.add(Product.fromJson(produto));
      });
    }
    if (json['validacoes'] != null) {
      validacoes = <InconsistenciaDeValidacao>[];
      json['validacoes'].forEach((inconsistencia) {
        validacoes!.add(InconsistenciaDeValidacao.fromJson(inconsistencia));
      });
    }
    sucesso = json['sucesso'];
    pagina = json['pagina'];
    quantidade = json['quantidade'];
    total = json['total'];
  }
}
