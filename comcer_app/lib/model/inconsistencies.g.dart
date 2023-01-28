// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inconsistencies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InconsistenciaDeValidacao _$InconsistenciaDeValidacaoFromJson(
        Map<String, dynamic> json) =>
    InconsistenciaDeValidacao(
      propriedade: json['propriedade'] as String,
      mensagem: json['mensagem'] as String,
      impedidtivo: json['impedidtivo'] as bool,
    );

Map<String, dynamic> _$InconsistenciaDeValidacaoToJson(
        InconsistenciaDeValidacao instance) =>
    <String, dynamic>{
      'propriedade': instance.propriedade,
      'mensagem': instance.mensagem,
      'impedidtivo': instance.impedidtivo,
    };
