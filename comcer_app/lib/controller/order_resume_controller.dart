import 'package:comcer_app/dominio/models/Product.dart';
import 'package:comcer_app/dominio/models/order_product.dart';
import 'package:flutter/cupertino.dart';

class OrderResumeController extends ChangeNotifier {
  List<OrderProduct> items = [];

  double productsPrice = 0.0;

  void addToOrder(Product product) {
    try {
      final entityProduct = items.firstWhere((p) => p.isEqual(product));
      entityProduct.quantidade++;
      _onProductUpdate();
    } catch (e) {
      final orderProduct = OrderProduct.fromProduto(product);
      orderProduct.addListener(_onProductUpdate);
      items.add(orderProduct);
      _onProductUpdate();
    }
    notifyListeners();
  }

  void removeOfOrder(OrderProduct orderProduct) {
    items.removeWhere((p) => p.produto == orderProduct.produto);
    orderProduct.removeListener(_onProductUpdate);
    notifyListeners();
  }

  void _onProductUpdate() {
    productsPrice = 0.0;
    for (int i = 0; i < items.length; i++) {
      final orderProduct = items[i];
      if (orderProduct.quantidade == 0) {
        removeOfOrder(orderProduct);
        i--;
        continue;
      }
      productsPrice += orderProduct.precoTotal;
    }
    notifyListeners();
  }
}
