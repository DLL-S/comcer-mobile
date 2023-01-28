import 'package:comcer_app/design/core.dart';
import 'package:comcer_app/controller/order_resume_controller.dart';
import 'package:comcer_app/views/components/card/order_product_card.dart';
import 'package:comcer_app/views/components/card/price_card.dart';
import 'package:comcer_app/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comcer_app/model/table.dart';

class OrderResumeScreen extends StatelessWidget {
  const OrderResumeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Mesa table = ModalRoute.of(context)!.settings.arguments as Mesa;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Constant.itensDoPedido),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Consumer<OrderResumeController>(
          builder: (_, orderResumeController, __) {
            return Container(
                color: CCColors.lightRed,
                child: orderResumeController.items.isEmpty
                    ? Container(
                        color: CCColors.lightRed,
                        alignment: Alignment.center,
                        child: Text(
                          Constant.nenhumItemAdicionado,
                          style: CCStyles.size22DarkRedBold,
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
                            child: PriceCard(table: table),
                          ),
                        ],
                      ));
          },
        ),
      ),
    );
  }
}
