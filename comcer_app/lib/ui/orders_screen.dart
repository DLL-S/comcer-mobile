import 'package:comcer_app/controller/order_controller.dart';
import 'package:comcer_app/core/app_colors.dart';
import 'package:comcer_app/core/app_styles.dart';
import 'package:comcer_app/dominio/models/ApiResponse.dart';
import 'package:comcer_app/dominio/models/OrderView.dart';
import 'package:comcer_app/ui/components/card/order_in_progress_card/OrderCard.dart';
import 'package:comcer_app/ui/products_of_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final orderController = OrderController();
  APIResponse<OrderView> _apiResponse = APIResponse<OrderView>();
  List<OrderView> orders = <OrderView>[];
  bool _isLoading = false;
  DateTime dataHora = DateTime.now();

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

  void listarPedidos() async {
    showLoading();
    _apiResponse = await orderController.listarPedidos();
    if (_apiResponse.data != null) {
      orders = _apiResponse.data!.resultados as List<OrderView>;
      orders = orders.where((element) => element.statusDoPedido != 3).toList();
    } else if (_apiResponse.error!) {
      hideLoading();
    }
    dataHora = DateTime.now().toLocal();
    hideLoading();
  }

  @override
  void initState() {
    listarPedidos();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightRed,
      child: RefreshIndicator(
        onRefresh: () async {
          listarPedidos();
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Column(
            children: [
              Text(
                'Última atualização em ' +
                    DateFormat('dd/MM/yyyy | HH:mm:ss').format(dataHora) +
                    'hrs',
                style: TextStyle(color: AppColors.darkRed),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(child: Builder(builder: (_) {
                if (_isLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.darkRed,
                    ),
                  );
                } else {
                  if (_apiResponse.error!) {
                    return Center(
                        child: Text(
                      "Houve um problema ao carregar os dados do serviço.\n " +
                          _apiResponse.errorMessage.toString(),
                      style: AppStyles.size18BlackBold,
                      textAlign: TextAlign.center,
                    ));
                  } else if (!_apiResponse.error! &&
                      _apiResponse.error == true) {
                    return Center(
                        child: Text(
                      _apiResponse.errorMessage.toString(),
                      style: AppStyles.size14BlackBold,
                      textAlign: TextAlign.center,
                    ));
                  } else if (orders.isEmpty) {
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        Text(
                          "Nenhum pedido a ser finalizado!",
                          style: AppStyles.size18DarkRedBold,
                          textAlign: TextAlign.center,
                        )
                      ],
                    );
                  } else {
                    return ListView.builder(
                        itemCount: orders.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext _, int index) {
                          return OrderCard(
                              order: orders[index],
                              onTap: () {
                                pushNewScreen(context,
                                    screen: ProducstOfOrderScreen(
                                        idPedido: orders[index].numeroDoPedido),
                                    withNavBar: false);
                              });
                        });
                  }
                }
              })),
            ],
          ),
        ),
      ),
    );
  }
}
