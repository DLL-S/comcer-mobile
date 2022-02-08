import 'package:comcer_app/controller/order_pad_controller.dart';
import 'package:comcer_app/controller/order_resume_controller.dart';
import 'package:comcer_app/core/app_colors.dart';
import 'package:comcer_app/core/app_styles.dart';
import 'package:comcer_app/dominio/models/order.dart';
import 'package:comcer_app/dominio/models/order_pad.dart';
import 'package:comcer_app/dominio/models/order_product.dart';
import 'package:comcer_app/dominio/models/ApiResponse.dart';
import 'package:comcer_app/ui/request_screen.dart';
import 'package:comcer_app/util/util.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class PriceCard extends StatelessWidget {

  const PriceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final orderResumeController = context.watch<OrderResumeController>();
    final productsPrice = orderResumeController.productsPrice;
    final OrderPadController orderPadController = OrderPadController();
    APIResponse<bool> isRegisteredOrder = APIResponse<bool>();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Resumo do Pedido',
              style: AppStyles.size14BlackBold,
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Valor Total',
                  style: AppStyles.size14BlackRegular,
                ),
                Text(
                  'R\$ ${productsPrice.toStringAsFixed(2)}',
                  style: AppStyles.size14BlackRegular,
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () async {
                  List<OrderProduct> orderProduct = [];
                  for(OrderProduct product in orderResumeController.items){
                    product.id = 0;
                    product.dataHoraPedido = Util.formatarDataHora(DateTime.now());
                    orderProduct.add(product);
                  }
                  Order order = Order(pedidosDoProduto: orderProduct);
                  order.id = 0;
                  order.dataHoraPedido = Util.formatarDataHora(DateTime.now());
                  // OrderPad orderPad = OrderPad(nome: 'Mesa 01', listaPedidos: []);
                  // orderPad.listaPedidos.add(order);
                  // orderPad.id = 0;
                  // orderPad.valor = 0;
                  // orderPad.status = 0;
                  // await orderPadController.addNewOrderPad(orderPad);
                  isRegisteredOrder = await orderPadController.addOrderInOrderPad(1, order);
                  if(isRegisteredOrder.data!){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pedido realizado com sucesso!'), backgroundColor: AppColors.green,));
                    orderResumeController.items.clear();
                    Future.delayed(Duration(seconds: 4)).then((value) => Navigator.restorablePushNamedAndRemoveUntil(context, '/base', (route) => false));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(isRegisteredOrder.errorMessage.toString()), backgroundColor: AppColors.red,));
                  }
                },
                child: Container(
                  height: 40,
                  width: 400,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.darkRed,
                  ),
                  child: Text(
                    "Finalizar Pedido",
                    style: AppStyles.size22WhiteBold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
