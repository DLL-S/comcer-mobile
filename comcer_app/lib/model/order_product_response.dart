import 'package:json_annotation/json_annotation.dart';
import 'base_api_response.dart';
import 'inconsistencies.dart';

part 'order_product_response.g.dart';

@JsonSerializable()
class OrderProductResponse extends BaseAPIResponse {
  late final int numeroMesa;
  late final int numeroDoPedido;
  late final int idProdutoPedido;
  late final String produtoPedido;
  late final int quantidadeProduto;
  late final String dataHoraPedido;
  late final int status;

  OrderProductResponse.empty();

  OrderProductResponse({
    required this.numeroMesa,
    required this.numeroDoPedido,
    required this.idProdutoPedido,
    required this.produtoPedido,
    required this.quantidadeProduto,
    required this.dataHoraPedido,
    required this.status,
  });

  factory OrderProductResponse.fromJson(Map<String,dynamic> json) => _$OrderProductResponseFromJson(json);

  Map<String,dynamic> toJson() => _$OrderProductResponseToJson(this);
}
