import 'package:json_annotation/json_annotation.dart';
import 'base_api_response.dart';
import 'inconsistencies.dart';
import 'order_product.dart';

part 'order.g.dart';

@JsonSerializable()
class Order extends BaseAPIResponse {
  int? id;
  late final List<OrderProduct> produtosDoPedido;
  String? dataHoraPedido;
  String? observacao;

  Order.empty();

  Order({
    this.id,
    required this.produtosDoPedido,
    this.dataHoraPedido,
    this.observacao
    }
  );

  factory Order.fromJson(Map<String,dynamic> json) => _$OrderFromJson(json);

  Map<String,dynamic> toJson() => _$OrderToJson(this);
}
