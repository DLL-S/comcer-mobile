<<<<<<<<< Temporary merge branch 1
enum OrderStatus { PENDENTE, COZINHANDO, PRONTO }
=========
enum OrderStatus {
 PENDENTE,
 COZINHANDO,
 PRONTO,
 ENTREGUE
}

extension OrderStatusExtension on OrderStatus {
 int get value {
  switch(this){
   case OrderStatus.PENDENTE:
    return 0;
   case OrderStatus.COZINHANDO:
    return 1;
   case OrderStatus.PRONTO:
    return 2;
   case OrderStatus.ENTREGUE:
    return 3;
  }
 }
}
