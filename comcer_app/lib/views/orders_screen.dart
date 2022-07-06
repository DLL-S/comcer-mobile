import 'package:comcer_app/controller/order_controller.dart';
import 'package:comcer_app/core/app_colors.dart';
import 'package:comcer_app/core/app_styles.dart';
import 'package:comcer_app/dominio/enum/order_status.dart';
import 'package:comcer_app/dominio/models/api_response.dart';
import 'package:comcer_app/dominio/models/order_view.dart';
import 'package:comcer_app/views/components/card/order_in_progress_card/OrderCard.dart';
import 'package:comcer_app/views/products_of_order_screen.dart';
import 'package:comcer_app/util/constant.dart';
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
      orders = orders.where((element) => element.statusDoPedido != OrderStatus.ENTREGUE.value).toList();
    } else if (_apiResponse.error!) {
      hideLoading();
    }
    dataHora = DateTime.now().toLocal();
    hideLoading();
  }

  @override
  void initState() {
    super.initState();
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
                Constant.ultimaAtualizacao +
                    DateFormat('dd/MM/yyyy | HH:mm:ss').format(dataHora) +
                    Constant.horas,
                style: const TextStyle(color: AppColors.darkRed),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(child: Builder(builder: (_) {
                if (_isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.darkRed,
                    ),
                  );
                } else {
                  if (_apiResponse.error!) {
                    return Center(
                        child: Text(
                      Constant.houveUmProblema +
                          _apiResponse.errorMessage.toString(),
                      style: AppStyles.size14BlackBold,
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
                          Constant.nenhumPedidoASerFinalizado,
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
