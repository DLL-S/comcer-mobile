// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mesa _$MesaFromJson(Map<String, dynamic> json) => Mesa(
      id: json['id'] as int,
      numero: json['numero'] as int,
      comandas: (json['comandas'] as List<dynamic>?)
          ?.map((e) => OrderPad.fromJson(e as Map<String, dynamic>))
          .toList(),
      disponivel: json['disponivel'] as bool,
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

Map<String, dynamic> _$MesaToJson(Mesa instance) => <String, dynamic>{
      'resultados': instance.resultados,
      'validacoes': instance.validacoes,
      'sucesso': instance.sucesso,
      'pagina': instance.pagina,
      'quantidade': instance.quantidade,
      'total': instance.total,
      'id': instance.id,
      'numero': instance.numero,
      'comandas': instance.comandas,
      'disponivel': instance.disponivel,
    };
