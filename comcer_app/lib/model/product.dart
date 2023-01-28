import 'package:comcer_app/model/base_api_response.dart';
import 'package:json_annotation/json_annotation.dart';

import 'inconsistencies.dart';

part 'product.g.dart';

@JsonSerializable()
class Product extends BaseAPIResponse {
  late int id;
  late String nome;
  late String descricao;
  late double preco;
  late String foto;

  Product.empty();

  Product(this.id, this.nome, this.descricao, this.preco, this.foto);

  factory Product.fromJson(Map<String,dynamic> json) => _$ProductFromJson(json);

  Map<String,dynamic> toJson() => _$ProductToJson(this);
}
