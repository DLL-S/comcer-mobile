// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_view.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderView _$OrderViewFromJson(Map<String, dynamic> json) => OrderView(
      numeroDaMesa: json['numeroDaMesa'] as int?,
      numeroDoPedido: json['numeroDoPedido'] as int?,
      statusDoPedido: json['statusDoPedido'] as int?,
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

Map<String, dynamic> _$OrderViewToJson(OrderView instance) => <String, dynamic>{
      'resultados': instance.resultados,
      'validacoes': instance.validacoes,
      'sucesso': instance.sucesso,
      'pagina': instance.pagina,
      'quantidade': instance.quantidade,
      'total': instance.total,
      'numeroDaMesa': instance.numeroDaMesa,
      'numeroDoPedido': instance.numeroDoPedido,
      'statusDoPedido': instance.statusDoPedido,
    };
