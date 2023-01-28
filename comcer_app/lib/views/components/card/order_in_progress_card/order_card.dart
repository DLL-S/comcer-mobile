import 'package:comcer_app/design/core.dart';
import 'package:comcer_app/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:comcer_app/enum/order_status.dart';
import 'package:comcer_app/model/order_view.dart';

class OrderCard extends StatelessWidget {
  final OrderView order;
  final VoidCallback onTap;

  const OrderCard({Key? key, required this.order, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget statusPedido(int status) {
      if (status == OrderStatus.pendente.value) {
        return const Text(
          Constant.statusPendente,
          style: TextStyle(
              color: CCColors.yellow,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        );
      } else if (status == OrderStatus.pronto.value) {
        return const Text(
          Constant.statusPronto,
          style: TextStyle(
              color: CCColors.green,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        );
      } else if (status == OrderStatus.entregue.value) {
        return const Text(
          Constant.statusEntregue,
          style: TextStyle(
              color: CCColors.darkGreen,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        );
      } else {
        return const Text(
          Constant.statusDesconhecido,
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18),
        );
      }
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: const Border.fromBorderSide(
            BorderSide(color: CCColors.darkRed),
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              const Text(
                Constant.mesaUpperCase,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                order.numeroDaMesa.toString(),
                style: const TextStyle(
                    color: CCColors.darkRed,
                    fontWeight: FontWeight.bold,
                    fontSize: 45),
              ),
            ],
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    Constant.pedidoComEspaco,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Text(
                    Constant.tresZeros + order.numeroDoPedido.toString(),
                    style: const TextStyle(
                        color: CCColors.darkRed,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    Constant.status,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  statusPedido(order.statusDoPedido!),
                ],
              ),
            ],
          ),
          const SizedBox(
            width: 8,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    Constant.verProdutos,
                    style: TextStyle(
                        color: CCColors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
