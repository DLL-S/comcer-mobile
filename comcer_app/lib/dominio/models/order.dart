import 'package:comcer_app/dominio/models/order_product.dart';

class Order {
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
    if (json['pedidosDoProduto'] != null) {
      _produtosDoPedido = <OrderProduct>[];
      json['pedidosDoProduto'].forEach((orderProduct) {
        _produtosDoPedido.add(OrderProduct.fromJson(orderProduct));
      });
    }
    _dataHoraPedido = json['dataHoraPedido'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['pedidosDoProduto'] =
        _produtosDoPedido.map((v) => v.toJson()).toList();
    data['dataHoraPedido'] = _dataHoraPedido;
    return data;
  }
}