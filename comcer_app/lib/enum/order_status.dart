enum OrderStatus { pendente, cozinhando, pronto, entregue, cancelado }

extension OrderStatusExtension on OrderStatus {
  int get value {
    switch(this) {
      case OrderStatus.pendente:
        return 0;
      case OrderStatus.cozinhando:
        return 1;
      case OrderStatus.pronto:
        return 2;
      case OrderStatus.entregue:
        return 3;
      case OrderStatus.cancelado:
        return 4;
    }
  }
}
