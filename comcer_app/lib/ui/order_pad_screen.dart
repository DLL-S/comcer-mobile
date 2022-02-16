import 'package:comcer_app/controller/order_pad_controller.dart';
import 'package:comcer_app/core/app_colors.dart';
import 'package:comcer_app/core/core.dart';
import 'package:comcer_app/dominio/models/ApiResponse.dart';
import 'package:comcer_app/dominio/models/order.dart';
import 'package:comcer_app/dominio/models/order_pad.dart';
import 'package:comcer_app/dominio/models/order_product.dart';
import 'package:comcer_app/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class OrderPadScreen extends StatefulWidget {
  final int tableNumber;

  const OrderPadScreen({Key? key, required this.tableNumber}) : super(key: key);

  @override
  _OrderPadScreenState createState() => _OrderPadScreenState();
}

class _OrderPadScreenState extends State<OrderPadScreen> {
  late int quantity = 0;
  int numeroPedido = 1;
  double totalValue = 0;

  OrderPadController orderPadController = OrderPadController();
  APIResponse<OrderPad> _apiResponse = APIResponse<OrderPad>();
  List<OrderPad> comandas = <OrderPad>[];

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

  void listarComanda() async {
    showLoading();
    _apiResponse =
        await orderPadController.buscaComadaPorMesa(widget.tableNumber);
    if (_apiResponse.data != null) {
      comandas = _apiResponse.data!.resultados as List<OrderPad>;
    } else if (_apiResponse.error!) {
      hideLoading();
    }
    if(mounted){
      setState(() {
        totalValue = comandas[0].valor!;
      });
    }
    hideLoading();
  }

  int increment() {
    return numeroPedido++;
  }


  @override
  void initState() {
    listarComanda();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkRed,
        title: Text("Comanda da Mesa " + widget.tableNumber.toString()),
        centerTitle: true,
      ),
      body: Container(
        color: AppColors.lightRed,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Visibility(
                visible: _isLoading ? false : true,
                child: Text(
                  'Pedidos',
                  style: AppStyles.size18DarkRedBold,
                  textAlign: TextAlign.left,
                )),
            Visibility(
                visible: _isLoading ? false : true,
                child: Divider(
                  color: AppColors.darkRed,
                  height: 2,
                )),
            const SizedBox(
              height: 8,
            ),
            Expanded(child: Builder(builder: (_) {
              numeroPedido = 1;
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
                    style: AppStyles.size14BlackBold,
                    textAlign: TextAlign.center,
                  ));
                } else if (!_apiResponse.error! &&
                    comandas[0].listaPedidos.length == 0) {
                  return Center(
                      child: Text(
                    _apiResponse.errorMessage.toString(),
                    style: AppStyles.size14BlackBold,
                    textAlign: TextAlign.center,
                  ));
                } else {
                  return ListView.builder(
                      itemCount: comandas[0].listaPedidos.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext _, int index) {
                        return Card(
                            child: ExpansionTile(
                          collapsedIconColor: AppColors.darkRed,
                          textColor: AppColors.darkRed,
                          collapsedTextColor: AppColors.darkRed,
                          iconColor: AppColors.darkRed,
                          title: Text('Pedido n.' + increment().toString()),
                          children: comandas[0]
                              .listaPedidos[index]
                              .pedidosDoProduto
                              .map((e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Produto: " + e.produto.nome,
                                          style: AppStyles.size14BlackBold,
                                        ),
                                        Text(
                                          'Quantidade: ' +
                                              e.quantidade.toString(),
                                          style: AppStyles.size14BlackBold,
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ));
                      });
                }
              }
            })),
            Visibility(
              visible: _isLoading ? false : true,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.darkRed,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Valor Total:', style: AppStyles.size22WhiteBold,),
                       Text('R\$ ' + totalValue.toStringAsFixed(2), style: AppStyles.size22WhiteBold,),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
