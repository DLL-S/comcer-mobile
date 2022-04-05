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
    if (mounted) {
      setState(() {
        totalValue = comandas[0].valor!;
      });
    }
    hideLoading();
  }

  int increment() {
    return numeroPedido++;
  }

  AlertDialog showCloseConfirmationDialog(
      BuildContext context, int orderPadNumber) {
    AlertDialog alerta = AlertDialog(
      title: const Text("Confirmação"),
      content: const Text("Deseja realmente fechar a comanda?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancelar")),
        TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/base', (Route<dynamic> route) => false);
            },
            child: const Text(
              "Sim",
              style: TextStyle(color: Colors.red),
            ))
      ],
    );
    return alerta;
  }

  bool orderPadCanBeClose(OrderPad orderPad) {
    bool validation = false;
    int lengthProduct = 0;
    int lengthOrder = 0;
    orderPad.listaPedidos.forEach((pedido) {
      pedido.pedidosDoProduto.forEach((produto) {
        if (produto.status == 3) {
          lengthProduct = lengthProduct;
        } else {
          lengthProduct++;
        }
      });
      if (lengthProduct == 0) {
        lengthOrder = lengthOrder;
      } else {
        lengthOrder++;
      }
    });
    if (lengthOrder == 0) {
      validation = true;
    } else {
      validation = false;
    }
    return validation;
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
        actions: [
          IconButton(
            onPressed: () {
              orderPadCanBeClose(comandas[0])
                  ? showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirmação"),
                          content: const Text("Deseja realmente fechar a comanda?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancelar")),
                            TextButton(
                                onPressed: () {
                                  orderPadController.closeOrderPad(comandas[0].id!);
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/base', (Route<dynamic> route) => false);
                                },
                                child: const Text(
                                  "Sim",
                                  style: TextStyle(color: Colors.red),
                                ))
                          ],
                        );
                      })
                  : showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Atenção"),
                          content: const Text(
                              "A comanda não pode ser encerrada pois ainda existem pedidos que não foram finalizados."),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Fechar"))
                          ],
                        );
                      });
            },
            icon: const Icon(
              Icons.check,
              color: Colors.white,
            ),
          )
        ],
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
                      Text(
                        'Valor Total:',
                        style: AppStyles.size22WhiteBold,
                      ),
                      Text(
                        'R\$ ' +
                            totalValue.toStringAsFixed(2).replaceAll('.', ','),
                        style: AppStyles.size22WhiteBold,
                      ),
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
