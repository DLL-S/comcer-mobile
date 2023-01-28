// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..usuario = json['usuario'] as String
  ..senha = json['senha'] as String
  ..token = json['token'] as String
  ..role = json['role'] as String;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'usuario': instance.usuario,
      'senha': instance.senha,
      'token': instance.token,
      'role': instance.role,
    };
