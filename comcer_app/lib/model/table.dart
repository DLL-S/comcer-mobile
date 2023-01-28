import 'package:json_annotation/json_annotation.dart';
import 'base_api_response.dart';
import 'order_pad.dart';
import 'inconsistencies.dart';


part 'table.g.dart';

@JsonSerializable()
class Mesa extends BaseAPIResponse {
  late final int id;
  late final int numero;
  late final List<OrderPad>? comandas;
  late final bool disponivel;

  Mesa.empty();

  Mesa({
    required this.id,
    required this.numero,
    this.comandas,
    required this.disponivel
    }
  );

  factory Mesa.fromJson(Map<String,dynamic> json) => _$MesaFromJson(json);

  Map<String,dynamic> toJson() => _$MesaToJson(this);
}
