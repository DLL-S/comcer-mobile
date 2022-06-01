import 'package:comcer_app/controller/order_pad_controller.dart';
import 'package:comcer_app/controller/order_resume_controller.dart';
import 'package:comcer_app/core/app_colors.dart';
import 'package:comcer_app/core/app_styles.dart';
import 'package:comcer_app/dominio/models/ApiResponse.dart';
import 'package:comcer_app/dominio/models/order.dart';
import 'package:comcer_app/dominio/models/order_pad.dart';
import 'package:comcer_app/dominio/models/order_product.dart';
import 'package:comcer_app/util/util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PriceCard extends StatefulWidget {
  final int tableNumber;

  const PriceCard({Key? key, required this.tableNumber}) : super(key: key);

  @override
  State<PriceCard> createState() => _PriceCardState();
}

class _PriceCardState extends State<PriceCard> {
  @override
  Widget build(BuildContext context) {
    final orderResumeController = context.watch<OrderResumeController>();
    final productsPrice = orderResumeController.productsPrice;
    final OrderPadController orderPadController = OrderPadController();
    APIResponse<OrderPad> hasOrderPad = APIResponse<OrderPad>();
    APIResponse<bool> isRegisteredOrder = APIResponse<bool>();
    bool _isLoading = false;

    void showLoading() {
      setState(() {
        _isLoading = true;
      });
    }

    void hideLoading() {
      setState(() {
        _isLoading = false;
      });
    }

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
                  showLoading();
                  List<OrderProduct> orderProduct = [];
                  for (OrderProduct product in orderResumeController.items) {
                    product.id = 0;
                    product.dataHoraPedido =
                        Util.formatarDataHora(DateTime.now());
                    orderProduct.add(product);
                  }
                  Order order = Order(pedidosDoProduto: orderProduct);
                  order.id = 0;
                  order.dataHoraPedido = Util.formatarDataHora(DateTime.now());

                  hasOrderPad = await orderPadController
                      .buscaComadaPorMesa(widget.tableNumber);

                  if (hasOrderPad.data!.resultados!.isEmpty) {
                    OrderPad orderPad = OrderPad(
                        nome: 'Mesa ${widget.tableNumber}', listaPedidos: []);
                    orderPad.listaPedidos.add(order);
                    orderPad.id = 0;
                    orderPad.valor = 0;
                    orderPad.status = 0;
                    isRegisteredOrder = await orderPadController.addNewOrderPad(
                        orderPad, widget.tableNumber);
                  } else {
                    OrderPad comanda =
                        hasOrderPad.data!.resultados!.first as OrderPad;
                    isRegisteredOrder = await orderPadController
                        .addOrderInOrderPad(order, comanda.id!);
                  }
                  hideLoading();
                  if (isRegisteredOrder.data!) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text('Pedido realizado com sucesso!'),
                      backgroundColor: AppColors.green,
                    ));
                    orderResumeController.items.clear();
                    Future.delayed(const Duration(seconds: 2)).then((value) =>
                        Navigator.restorablePushNamedAndRemoveUntil(
                            context, '/base', (route) => false));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(isRegisteredOrder.errorMessage.toString()),
                      backgroundColor: AppColors.red,
                    ));
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
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Text(
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
