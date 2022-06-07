import 'package:comcer_app/controller/order_resume_controller.dart';
import 'package:comcer_app/core/app_colors.dart';
import 'package:comcer_app/core/app_styles.dart';
import 'package:comcer_app/ui/components/card/order_product_card.dart';
import 'package:comcer_app/ui/components/card/price_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderResumeScreen extends StatelessWidget {
  OrderResumeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int tableNumber = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Itens do Pedido"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Consumer<OrderResumeController>(
        builder: (_, orderResumeController, __) {
          return Container(
              color: AppColors.lightRed,
              child: orderResumeController.items.isEmpty
                  ? Container(
                      color: AppColors.lightRed,
                      alignment: Alignment.center,
                      child: Text(
                        "Nenhum item adicionado ao pedido.",
                        style: AppStyles.size22DarkRedBold,
                      ))
                  : ListView(
                      children: [
                        Column(
                          children: orderResumeController.items
                              .map((orderProduct) => OrderProductCard(
                                    orderProduct: orderProduct,
                                  ))
                              .toList(),
                        ),
                        Visibility(
                          visible: orderResumeController.items.isEmpty
                              ? false
                              : true,
                          child: PriceCard(tableNumber: tableNumber),
                        ),
                      ],
                    ));
        },
      ),
    );
  }
}
