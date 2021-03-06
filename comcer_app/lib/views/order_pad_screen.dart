import 'package:comcer_app/controller/order_pad_controller.dart';
import 'package:comcer_app/core/core.dart';
import 'package:comcer_app/dominio/enum/order_status.dart';
import 'package:comcer_app/dominio/models/api_response.dart';
import 'package:comcer_app/dominio/models/order.dart';
import 'package:comcer_app/dominio/models/order_pad.dart';
import 'package:comcer_app/dominio/models/table_model.dart';
import 'package:comcer_app/util/constants.dart';
import 'package:flutter/material.dart';

class OrderPadScreen extends StatefulWidget {
  final Mesa table;

  const OrderPadScreen({Key? key, required this.table}) : super(key: key);

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
    _apiResponse = await orderPadController.buscaComadaPorMesa(widget.table.id);
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
      title: const Text(Constant.confirmacao),
      content: const Text(Constant.fecharComanda),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(Constant.cancelar)),
        TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/base', (Route<dynamic> route) => false);
            },
            child: const Text(
              Constant.sim,
              style: TextStyle(color: Colors.red),
            ))
      ],
    );
    return alerta;
  }

  String valorTotalDoProduto(int quantidade, double valorUnitario) {
    final valorTotal = valorUnitario * quantidade;
    return ("Valor: R\$ ${valorTotal.toStringAsFixed(2).replaceAll('.', ',')}");
  }

  bool orderPadCanBeClose(OrderPad orderPad) {
    bool validation = false;
    int lengthProduct = 0;
    int lengthOrder = 0;
    for (var pedido in orderPad.listaPedidos) {
      for (var produto in pedido.pedidosDoProduto) {
        if (produto.status == OrderStatus.ENTREGUE.value ||
            produto.status == OrderStatus.CANCELADO.value) {
          lengthProduct = lengthProduct;
        } else {
          lengthProduct++;
        }
      }
      if (lengthProduct == 0) {
        lengthOrder = lengthOrder;
      } else {
        lengthOrder++;
      }
    }
    if (lengthOrder == 0) {
      validation = true;
    } else {
      validation = false;
    }
    return validation;
  }

  bool orderWasCancelled(Order order) {
    bool validation = false;
    int lengthProduct = 0;
    for (var produto in order.pedidosDoProduto) {
      if (produto.status == OrderStatus.CANCELADO.value) {
        lengthProduct = lengthProduct;
      } else {
        lengthProduct++;
      }
    }
    if (lengthProduct == 0) {
      validation = true;
    } else {
      validation = false;
    }
    return validation;
  }

  @override
  void initState() {
    super.initState();
    listarComanda();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkRed,
        title: Text(Constant.comandaDaMesa + widget.table.numero.toString()),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              orderPadCanBeClose(comandas[0])
                  ? showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(Constant.confirmacao),
                          content: const Text(Constant.fecharComanda),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(Constant.cancelar)),
                            TextButton(
                                onPressed: () {
                                  orderPadController
                                      .closeOrderPad(comandas[0].id!);
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      '/base', (Route<dynamic> route) => false);
                                },
                                child: const Text(
                                  Constant.sim,
                                  style: TextStyle(color: Colors.red),
                                ))
                          ],
                        );
                      })
                  : showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(Constant.atencao),
                          content: const Text(Constant.naoPodeSerEncerrada),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(Constant.fechar))
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
                  Constant.pedidos,
                  style: AppStyles.size18DarkRedBold,
                  textAlign: TextAlign.left,
                )),
            Visibility(
                visible: _isLoading ? false : true,
                child: const Divider(
                  color: AppColors.darkRed,
                  height: 2,
                )),
            const SizedBox(
              height: 8,
            ),
            Expanded(child: Builder(builder: (_) {
              numeroPedido = 1;
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
                    comandas[0].listaPedidos.isEmpty) {
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
                          title: Text(Constant.pedidoNumero +
                              increment().toString() +
                              (orderWasCancelled(
                                      comandas[0].listaPedidos[index])
                                  ? " Cancelado"
                                  : "")),
                          children: comandas[0]
                              .listaPedidos[index]
                              .pedidosDoProduto
                              .map((e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                Constant.produto + e.produto.nome,
                                                style: e.status ==
                                                        OrderStatus.CANCELADO.value
                                                    ? AppStyles.size14DarkRedRegular
                                                        .copyWith(
                                                            decoration: e.status ==
                                                                    OrderStatus
                                                                        .CANCELADO
                                                                        .value
                                                                ? TextDecoration
                                                                    .lineThrough
                                                                : TextDecoration.none)
                                                    : AppStyles.size14BlackBold
                                                        .copyWith(
                                                            decoration: e.status ==
                                                                    OrderStatus
                                                                        .CANCELADO
                                                                        .value
                                                                ? TextDecoration
                                                                    .lineThrough
                                                                : TextDecoration
                                                                    .none),
                                              ),
                                            ),
                                            Text(
                                              Constant.quantidade +
                                                  e.quantidade.toString(),
                                              style: e.status ==
                                                      OrderStatus.CANCELADO.value
                                                  ? AppStyles.size14DarkRedRegular
                                                      .copyWith(
                                                          decoration: e.status ==
                                                                  OrderStatus
                                                                      .CANCELADO
                                                                      .value
                                                              ? TextDecoration
                                                                  .lineThrough
                                                              : TextDecoration.none)
                                                  : AppStyles.size14BlackBold
                                                      .copyWith(
                                                          decoration: e.status ==
                                                                  OrderStatus
                                                                      .CANCELADO
                                                                      .value
                                                              ? TextDecoration
                                                                  .lineThrough
                                                              : TextDecoration
                                                                  .none),
                                            )
                                          ],
                                        ),
                                        Text(valorTotalDoProduto(e.quantidade, e.valorUnitario), style: e.status ==
                                        OrderStatus.CANCELADO.value
                                        ? AppStyles.size14DarkRedRegular
                                            .copyWith(
                                        decoration: e.status ==
                                        OrderStatus
                                            .CANCELADO
                                            .value
                                        ? TextDecoration
                                            .lineThrough
                                            : TextDecoration.none)
                                  : AppStyles.size14BlackBold
                              .copyWith(
                          decoration: e.status ==
                          OrderStatus
                              .CANCELADO
                              .value
                          ? TextDecoration
                              .lineThrough
                              : TextDecoration
                              .none),),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        const Divider(height: 2,)
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
                        Constant.valorTotalComDoisPontos,
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
