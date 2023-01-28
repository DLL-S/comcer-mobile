// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderProductResponse _$OrderProductResponseFromJson(
        Map<String, dynamic> json) =>
    OrderProductResponse(
      numeroMesa: json['numeroMesa'] as int,
      numeroDoPedido: json['numeroDoPedido'] as int,
      idProdutoPedido: json['idProdutoPedido'] as int,
      produtoPedido: json['produtoPedido'] as String,
      quantidadeProduto: json['quantidadeProduto'] as int,
      dataHoraPedido: json['dataHoraPedido'] as String,
      status: json['status'] as int,
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

Map<String, dynamic> _$OrderProductResponseToJson(
        OrderProductResponse instance) =>
    <String, dynamic>{
      'resultados': instance.resultados,
      'validacoes': instance.validacoes,
      'sucesso': instance.sucesso,
      'pagina': instance.pagina,
      'quantidade': instance.quantidade,
      'total': instance.total,
      'numeroMesa': instance.numeroMesa,
      'numeroDoPedido': instance.numeroDoPedido,
      'idProdutoPedido': instance.idProdutoPedido,
      'produtoPedido': instance.produtoPedido,
      'quantidadeProduto': instance.quantidadeProduto,
      'dataHoraPedido': instance.dataHoraPedido,
      'status': instance.status,
    };
