import 'package:json_annotation/json_annotation.dart';
import 'base_api_response.dart';
import 'inconsistencies.dart';

part 'order_view.g.dart';

@JsonSerializable()
class OrderView extends BaseAPIResponse {
  int? numeroDaMesa;
  int? numeroDoPedido;
  int? statusDoPedido;

  OrderView.empty();

  OrderView({this.numeroDaMesa, this.numeroDoPedido, this.statusDoPedido});

  factory OrderView.fromJson(Map<String,dynamic> json) => _$OrderViewFromJson(json);

  Map<String,dynamic> toJson() => _$OrderViewToJson(this);
}
