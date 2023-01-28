// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_pad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderPad _$OrderPadFromJson(Map<String, dynamic> json) => OrderPad(
      id: json['id'] as int?,
      nome: json['nome'] as String,
      listaPedidos: (json['listaPedidos'] as List<dynamic>)
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
      valor: (json['valor'] as num?)?.toDouble(),
      status: json['status'] as int?,
      aberturaComanda: json['aberturaComanda'] as String?,
      encerramentoComanda: json['encerramentoComanda'] as String?,
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

Map<String, dynamic> _$OrderPadToJson(OrderPad instance) => <String, dynamic>{
      'resultados': instance.resultados,
      'validacoes': instance.validacoes,
      'sucesso': instance.sucesso,
      'pagina': instance.pagina,
      'quantidade': instance.quantidade,
      'total': instance.total,
      'id': instance.id,
      'nome': instance.nome,
      'listaPedidos': instance.listaPedidos,
      'valor': instance.valor,
      'status': instance.status,
      'aberturaComanda': instance.aberturaComanda,
      'encerramentoComanda': instance.encerramentoComanda,
    };
