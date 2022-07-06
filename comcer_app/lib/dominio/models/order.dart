import 'package:comcer_app/dominio/models/base_api_response.dart';
import 'package:comcer_app/dominio/models/order_product.dart';

import 'inconsistencies.dart';

class Order extends BaseAPIResponse {
  int? _id;
  late final List<OrderProduct> _produtosDoPedido;
  String? _dataHoraPedido;

  Order.empty();

  Order(
      {int? id,
      required List<OrderProduct> pedidosDoProduto,
      String? dataHoraPedido}) {
    if (id != null) {
      _id = id;
    }
    _produtosDoPedido = pedidosDoProduto;
    if (dataHoraPedido != null) {
      _dataHoraPedido = dataHoraPedido;
    }
  }

  int? get id => _id;

  set id(int? id) => _id = id;

  List<OrderProduct> get pedidosDoProduto => _produtosDoPedido;

  set pedidosDoProduto(List<OrderProduct> pedidosDoProduto) =>
      _produtosDoPedido = pedidosDoProduto;

  String? get dataHoraPedido => _dataHoraPedido;

  set dataHoraPedido(String? dataHoraPedido) =>
      _dataHoraPedido = dataHoraPedido;

  Order.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    if (json['produtosDoPedido'] != null) {
      _produtosDoPedido = <OrderProduct>[];
      json['produtosDoPedido'].forEach((orderProduct) {
        _produtosDoPedido.add(OrderProduct.fromJson(orderProduct));
      });
    }
    _dataHoraPedido = json['dataHoraPedido'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['produtosDoPedido'] =
        _produtosDoPedido.map((v) => v.toJson()).toList();
    data['dataHoraPedido'] = _dataHoraPedido;
    return data;
  }

  Order.fromJsonResponse(Map<String, dynamic> json) {
    if (json['resultados'] != null) {
      resultados = <Order>[];
      json['resultados'].forEach((mesa) {
        resultados!.add(Order.fromJson(mesa));
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
