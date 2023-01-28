import 'package:comcer_app/core/core.dart';
import 'package:comcer_app/views/shared/icon_button/custom_icon_button.dart';
import 'package:comcer_app/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/order_product.dart';

class OrderProductCard extends StatelessWidget {
  const OrderProductCard({Key? key, required this.orderProduct})
      : super(key: key);
  final OrderProduct orderProduct;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: orderProduct,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderProduct.product.nome,
                      style: AppStyles.size14BlackBold,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          Constant.valorUnitario,
                          style: AppStyles.size14DarkRedBold,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'R\$${orderProduct.product.preco.toStringAsFixed(2).replaceAll(".", ",")}',
                          style: AppStyles.size14BlackBold,
                        ),
                      ],
                    ),
                  ],
                ),
              )),
              Consumer<OrderProduct>(
                builder: (_, orderProduct, __) {
                  return Row(
                    children: [
                      CustomIconButton(
                          iconData: Icons.add,
                          color: AppColors.darkRed,
                          onTap: orderProduct.increment),
                      Text(
                        '${orderProduct.quantidade}',
                        style: AppStyles.size14BlackBold,
                      ),
                      CustomIconButton(
                          iconData: Icons.remove,
                          color: AppColors.darkRed,
                          onTap: orderProduct.decrement),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
