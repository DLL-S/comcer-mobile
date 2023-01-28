// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderProduct _$OrderProductFromJson(Map<String, dynamic> json) => OrderProduct(
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      quantidade: json['quantidade'] as int,
      valorUnitario: (json['valorUnitario'] as num).toDouble(),
      status: json['status'] as int,
      dataHoraPedido: json['dataHoraPedido'] as String?,
    )..id = json['id'] as int?;

Map<String, dynamic> _$OrderProductToJson(OrderProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product': instance.product,
      'quantidade': instance.quantidade,
      'valorUnitario': instance.valorUnitario,
      'status': instance.status,
      'dataHoraPedido': instance.dataHoraPedido,
    };
