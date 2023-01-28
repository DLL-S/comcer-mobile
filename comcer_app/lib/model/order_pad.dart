import 'package:json_annotation/json_annotation.dart';
import 'base_api_response.dart';
import 'order.dart';
import 'inconsistencies.dart';

part 'order_pad.g.dart';

@JsonSerializable()
class OrderPad extends BaseAPIResponse {
  int? id;
  late final String nome;
  late final List<Order> listaPedidos;
  double? valor;
  int? status;
  String? aberturaComanda;
  String? encerramentoComanda;

  OrderPad.empty();

  OrderPad({
    this.id,
    required this.nome,
    required this.listaPedidos,
    this.valor,
    this.status,
    this.aberturaComanda,
    this.encerramentoComanda
    }
  );

  factory OrderPad.fromJson(Map<String,dynamic> json) => _$OrderPadFromJson(json);

  Map<String,dynamic> toJson() => _$OrderPadToJson(this);
}
