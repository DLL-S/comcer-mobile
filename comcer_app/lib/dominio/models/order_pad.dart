import 'package:comcer_app/dominio/models/base_api_response.dart';

import 'inconsistencies.dart';
import 'order.dart';

class OrderPad extends BaseAPIResponse {
  int? _id;
  late final String _nome;
  late final List<Order> _listaPedidos;
  double? _valor;
  int? _status;
  String? _aberturComanda;
  String? _encerramentoComanda;

  OrderPad.empty();

  OrderPad(
      {int? id,
      required String nome,
      required List<Order> listaPedidos,
      double? valor,
      int? status,
      String? aberturaComanda,
      String? encerrarComanda}) {
    if (id != null) {
      _id = id;
    }
    if (nome != null) {
      _nome = nome;
    }
    if (listaPedidos != null) {
      _listaPedidos = listaPedidos;
    }
    if (valor != null) {
      _valor = valor;
    }
    if (status != null) {
      _status = status;
    }
    if (aberturaComanda != null) {
      _aberturComanda = aberturaComanda;
    }
    if (encerrarComanda != null) {
      _encerramentoComanda = encerrarComanda;
    }
  }

  int? get id => _id;

  set id(int? id) => _id = id;

  String get nome => _nome;

  set nome(String nome) => _nome = nome;

  List<Order> get listaPedidos => _listaPedidos;

  set listaPedidos(List<Order> listaPedidos) => _listaPedidos = listaPedidos;

  double? get valor => _valor;

  set valor(double? valor) => _valor = valor;

  int? get status => _status;

  set status(int? status) => _status = status;

  String? get aberturaComanda => _aberturComanda;

  set aberturaComanda(String? aberturaComanda) =>
      _aberturComanda = aberturaComanda;

  String? get encerramentoComanda => _encerramentoComanda;

  set encerramentoComanda(String? encerramentoComanda) =>
      _encerramentoComanda = encerramentoComanda;

  OrderPad.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _nome = json['nome'];
    if (json['listaPedidos'] != null) {
      _listaPedidos = <Order>[];
      json['listaPedidos'].forEach((order) {
        _listaPedidos.add(Order.fromJson(order));
      });
    }
    _valor = json['valor'].toDouble();
    _status = json['status'];
    _aberturComanda = json['aberturaComanda'];
    _encerramentoComanda = json['encerramentoComanda'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['nome'] = _nome;
    if (_listaPedidos != null) {
      data['listaPedidos'] = _listaPedidos.map((v) => v.toJson()).toList();
    }
    data['valor'] = _valor;
    data['status'] = _status;
    data['aberturaComanda'] = '0001-01-01T00:00:00.0Z';
    data['encerramentoComanda'] = null;
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
