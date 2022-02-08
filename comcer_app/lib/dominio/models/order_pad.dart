import 'package:comcer_app/dominio/models/BaseAPIResponse.dart';

import 'inconsistencia_validacao.dart';
import 'order.dart';

class OrderPad extends BaseAPIResponse {
  int? _id;
  late final String _nome;
  late final List<Order> _listaPedidos;
  int? _valor;
  int? _status;

  OrderPad.empty();

  OrderPad(
      {int? id,
        required String nome,
        required List<Order> listaPedidos,
        int? valor,
        int? status}) {
    if (id != null) {
      this._id = id;
    }
    if (nome != null) {
      this._nome = nome;
    }
    if (listaPedidos != null) {
      this._listaPedidos = listaPedidos;
    }
    if (valor != null) {
      this._valor = valor;
    }
    if (status != null) {
      this._status = status;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String get nome => _nome;
  set nome(String nome) => _nome = nome;
  List<Order> get listaPedidos => _listaPedidos;
  set listaPedidos(List<Order> listaPedidos) =>
      _listaPedidos = listaPedidos;
  int? get valor => _valor;
  set valor(int? valor) => _valor = valor;
  int? get status => _status;
  set status(int? status) => _status = status;

  OrderPad.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _nome = json['nome'];
    if (json['listaPedidos'] != null) {
      _listaPedidos = <Order>[];
      json['listaPedidos'].forEach((order) {
        _listaPedidos.add(Order.fromJson(order));
      });
    }
    _valor = json['valor'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['nome'] = this._nome;
    if (this._listaPedidos != null) {
      data['listaPedidos'] =
          this._listaPedidos.map((v) => v.toJson()).toList();
    }
    data['valor'] = this._valor;
    data['status'] = this._status;
    return data;
  }

  OrderPad.fromJsonResponse(Map<String, dynamic> json) {
    if (json['resultados'] != null) {
      resultados = <OrderPad>[];
      json['resultados'].forEach((orderProduct) {
        resultados!.add(OrderPad.fromJson(orderProduct));
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
