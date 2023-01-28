import 'package:comcer_app/design/core.dart';
import 'package:comcer_app/controller/order_pad_controller.dart';
import 'package:comcer_app/controller/order_resume_controller.dart';
import 'package:comcer_app/util/constants.dart';
import 'package:comcer_app/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comcer_app/enum/order_pad_status.dart';
import 'package:comcer_app/model/api_response.dart';
import 'package:comcer_app/model/order.dart';
import 'package:comcer_app/model/order_pad.dart';
import 'package:comcer_app/model/order_product.dart';
import 'package:comcer_app/model/table.dart';

class PriceCard extends StatefulWidget {
  final Mesa table;

  const PriceCard({Key? key, required this.table}) : super(key: key);

  @override
  State<PriceCard> createState() => _PriceCardState();
}

class _PriceCardState extends State<PriceCard> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final orderResumeController = context.watch<OrderResumeController>();
    TextEditingController observacaoController = TextEditingController();
    final productsPrice = orderResumeController.productsPrice;
    final OrderPadController orderPadController = OrderPadController();
    APIResponse<OrderPad> hasOrderPad = APIResponse<OrderPad>();
    APIResponse<bool> isRegisteredOrder = APIResponse<bool>();

    void showLoading() {
      if(mounted){
        setState(() {
          _isLoading = true;
        });
      }
    }

    void hideLoading() {
      if (mounted){
        setState(() {
          _isLoading = false;
        });
      }
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              Constant.resumoDoPedido,
              style: CCStyles.size14BlackBold,
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: observacaoController,
              keyboardType: TextInputType.multiline,
              enabled: !_isLoading,
              maxLines: null,
              maxLength: 140,
              decoration: const InputDecoration(
                  labelText: Constant.observacao,
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: CCColors.darkRed)),
                  labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black)),
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  Constant.valorTotal,
                  style: CCStyles.size14BlackRegular,
                ),
                Text(
                  'R\$ ${productsPrice.toStringAsFixed(2)}',
                  style: CCStyles.size14BlackRegular,
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
                  Order order = Order(produtosDoPedido: orderProduct);
                  order.id = 0;
                  order.dataHoraPedido = Util.formatarDataHora(DateTime.now());
                  order.observacao = observacaoController.text;

                  hasOrderPad = await orderPadController
                      .buscaComadaPorMesa(widget.table.id);

                  if (hasOrderPad.data!.resultados!.isEmpty) {
                    OrderPad orderPad = OrderPad(
                        nome: '${Constant.mesa} ${widget.table.numero}', listaPedidos: []);
                    orderPad.listaPedidos.add(order);
                    orderPad.id = 0;
                    orderPad.valor = 0;
                    orderPad.status = OrderPadStatus.aberta.value;
                    isRegisteredOrder = await orderPadController.addNewOrderPad(
                        orderPad, widget.table.id);
                  } else {
                    OrderPad comanda =
                        hasOrderPad.data!.resultados!.first as OrderPad;
                    isRegisteredOrder = await orderPadController
                        .addOrderInOrderPad(order, comanda.id!);
                  }
                  hideLoading();
                  if (isRegisteredOrder.data!) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(Constant.pedidoRealizadoComSucesso),
                      backgroundColor: CCColors.darkGreen,
                      duration: Duration(seconds: 2),
                    ));
                    orderResumeController.items.clear();
                        Navigator.restorablePushNamedAndRemoveUntil(
                            context, '/base', (route) => false);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(isRegisteredOrder.errorMessage.toString()),
                      backgroundColor: CCColors.red,
                    ));
                  }
                },
                child: Container(
                  height: 40,
                  width: 400,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: CCColors.darkRed,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                    color: CCColors.lightRed,
                  )
                      : const Text(
                          Constant.finalizarPedido,
                          style: CCStyles.size18WhiteBold,
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
