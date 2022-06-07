import 'package:comcer_app/dominio/models/BaseAPIResponse.dart';

import 'inconsistencia_validacao.dart';

class OrderProductResponse extends BaseAPIResponse {
  //Atributos do OrderProduct
  late final int _numeroMesa;
  late final int _numeroDoPedido;
  late final int _idProdutoPedido;
  late final String _produtoPedido;
  late final String _dataHoraPedido;
  late final int _status;

  OrderProductResponse.empty();

  OrderProductResponse(
    this._numeroMesa,
    this._numeroDoPedido,
    this._idProdutoPedido,
    this._produtoPedido,
    this._dataHoraPedido,
    this._status,
  );

  //Getters and Setters
  int get numeroMesa => _numeroMesa;

  set numeroMesa(int value) {
    _numeroMesa = value;
  }

  int get numeroDoPedido => _numeroDoPedido;

  set numeroDoPedido(int value) {
    _numeroDoPedido = value;
  }

  int get idProdutoPedido => _idProdutoPedido;

  set idProdutoPedido(int value) {
    _idProdutoPedido = value;
  }

  String get produtoPedido => _produtoPedido;

  set produtoPedido(String value) {
    _produtoPedido = value;
  }

  String get dataHoraPedido => _dataHoraPedido;

  set dataHoraPedido(String value) {
    _dataHoraPedido = value;
  }

  int get status => _status;

  set status(int value) {
    _status = value;
  }

  //Converter JSON para classe
  OrderProductResponse.fromJson(Map<String, dynamic> json) {
    _numeroMesa = json["numeroMesa"].toInt();
    _numeroDoPedido = json["numeroPedido"].toInt();
    _idProdutoPedido = json["idProdutoPedido"].toInt();
    _produtoPedido = json["produtoPedido"].toString();
    _dataHoraPedido = json["dataHoraPedido"].toString();
    _status = json["statusPedido"].toInt();
  }

  //Converter classe para JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["numeroMesa"] = _numeroMesa;
    data["numeroPedido"] = _numeroDoPedido;
    data["idProdutoPedido"] = _idProdutoPedido;
    data["produtoPedido"] = _produtoPedido;
    data["status"] = _status;
    return data;
  }

  OrderProductResponse.fromJsonResponse(Map<String, dynamic> json) {
    if (json['resultados'] != null) {
      resultados = <OrderProductResponse>[];
      json['resultados'].forEach((produto) {
        resultados!.add(OrderProductResponse.fromJson(produto));
      });
    }
    if (json['validacoes'] != null) {
      validacoes = <InconsistenciaDeValidacao>[];
      json['validacoes'].forEach((inconsistencia) {
        validacoes!.add(InconsistenciaDeValidacao.fromJson(inconsistencia));
      });
    }
    sucesso = json['sucesso'];
    pagina = json['pagina'];
    quantidade = json['quantidade'];
    total = json['total'];
  }
}
