// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseAPIResponse _$BaseAPIResponseFromJson(Map<String, dynamic> json) =>
    BaseAPIResponse(
      resultados: (json['resultados'] as List<dynamic>?)
          ?.map((e) => e as Object)
          .toList(),
      validacoes: (json['validacoes'] as List<dynamic>?)
          ?.map((e) =>
              InconsistenciaDeValidacao.fromJson(e as Map<String, dynamic>))
          .toList(),
      sucesso: json['sucesso'] as bool?,
      pagina: json['pagina'] as int?,
      quantidade: json['quantidade'] as int?,
      total: json['total'] as int?,
    );

Map<String, dynamic> _$BaseAPIResponseToJson(BaseAPIResponse instance) =>
    <String, dynamic>{
      'resultados': instance.resultados,
      'validacoes': instance.validacoes,
      'sucesso': instance.sucesso,
      'pagina': instance.pagina,
      'quantidade': instance.quantidade,
      'total': instance.total,
    };
