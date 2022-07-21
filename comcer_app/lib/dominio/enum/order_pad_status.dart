enum OrderPadStatus { ABERTA, AGUARDANDO_PAGAMENTO, FECHADA }

extension OrderPadStatusExtension on OrderPadStatus {
  int get value {
    switch(this) {
      case OrderPadStatus.ABERTA:
        return 0;
      case OrderPadStatus.AGUARDANDO_PAGAMENTO:
        return 1;
      case OrderPadStatus.FECHADA:
        return 2;
    }
  }
}
