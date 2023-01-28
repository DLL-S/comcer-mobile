// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as int?,
      produtosDoPedido: (json['produtosDoPedido'] as List<dynamic>)
          .map((e) => OrderProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      dataHoraPedido: json['dataHoraPedido'] as String?,
      observacao: json['observacao'] as String?,
    )
      ..resultados = (json['resultados'] as List<dynamic>?)
          ?.map((e) => e as Object)
          .toList()
      ..validacoes = (json['validacoes'] as List<dynamic>?)
          ?.map((e) =>
              InconsistenciaDeValidacao.fromJson(e as Map<String, dynamic>))
          .toList()
      ..sucesso = json['sucesso'] as bool?
      ..pagina = json['pagina'] as int?
      ..quantidade = json['quantidade'] as int?
      ..total = json['total'] as int?;

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'resultados': instance.resultados,
      'validacoes': instance.validacoes,
      'sucesso': instance.sucesso,
      'pagina': instance.pagina,
      'quantidade': instance.quantidade,
      'total': instance.total,
      'id': instance.id,
      'produtosDoPedido': instance.produtosDoPedido,
      'dataHoraPedido': instance.dataHoraPedido,
      'observacao': instance.observacao,
    };
