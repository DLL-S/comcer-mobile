enum OrderPadStatus { aberta, aguardandoPagamento, fechada }

extension OrderPadStatusExtension on OrderPadStatus {
  int get value {
    switch(this) {
      case OrderPadStatus.aberta:
        return 0;
      case OrderPadStatus.aguardandoPagamento:
        return 1;
      case OrderPadStatus.fechada:
        return 2;
    }
  }
}
