import 'package:comcer_app/controller/order_product_controller.dart';
import 'package:comcer_app/design/core.dart';
import 'package:comcer_app/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:comcer_app/enum/order_status.dart';
import 'package:comcer_app/model/api_response.dart';
import 'package:comcer_app/model/order_product_response.dart';

class ProducstOfOrderScreen extends StatefulWidget {
  final int? idPedido;

  const ProducstOfOrderScreen({Key? key, required this.idPedido})
      : super(key: key);

  @override
  _ProducstOfOrderScreenState createState() => _ProducstOfOrderScreenState();
}

class _ProducstOfOrderScreenState extends State<ProducstOfOrderScreen> {
  final orderProductController = OrderProductController();
  APIResponse<OrderProductResponse> _apiResponse =
      APIResponse<OrderProductResponse>();
  List<OrderProductResponse> productsOfOrder = <OrderProductResponse>[];
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

  void listarProdutosDoPedido() async {
    showLoading();
    _apiResponse =
        await orderProductController.listarProdutosDoPedido(widget.idPedido!);
    if (_apiResponse.data != null) {
      productsOfOrder =
          _apiResponse.data!.resultados as List<OrderProductResponse>;
    } else if (_apiResponse.error!) {
      hideLoading();
    }
    hideLoading();
  }

  @override
  void initState() {
    super.initState();
    listarProdutosDoPedido();
  }

  @override
  Widget build(BuildContext context) {
    Widget statusPedido(int status) {
      if (status == OrderStatus.pendente.value) {
        return const Text(
          Constant.statusPendente,
          style: TextStyle(
              color: CCColors.yellow,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        );
      } else if (status == OrderStatus.cozinhando.value) {
        return const Text(
          Constant.statusCozinhando,
          style: TextStyle(
              color: CCColors.orange,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        );
      } else if (status == OrderStatus.pronto.value) {
        return const Text(
          Constant.statusPronto,
          style: TextStyle(
              color: CCColors.green,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        );
      } else if (status == OrderStatus.entregue.value) {
        return const Text(
          Constant.statusEntregue,
          style: TextStyle(
              color: CCColors.darkGreen,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        );
      } else if (status == OrderStatus.cancelado.value) {
        return const Text(
          Constant.statusCancelado,
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14),
        );
      } else {
        return const Text(
          Constant.statusDesconhecido,
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CCColors.darkRed,
        title: const Text(Constant.produtosDoPedido),
        centerTitle: true,
      ),
      body: Container(
        color: CCColors.lightRed,
        child: Column(
          children: [
            Expanded(child: Builder(builder: (_) {
              if (_isLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: CCColors.darkRed,
                  ),
                );
              } else {
                if (_apiResponse.error!) {
                  return Center(
                      child: Text(
                    Constant.houveUmProblema +
                        _apiResponse.errorMessage.toString(),
                    style: CCStyles.size14BlackBold,
                    textAlign: TextAlign.center,
                  ));
                } else if (!_apiResponse.error! && productsOfOrder.isEmpty) {
                  return Center(
                      child: Text(
                    _apiResponse.errorMessage.toString(),
                    style: CCStyles.size14BlackBold,
                    textAlign: TextAlign.center,
                  ));
                } else {
                  return ListView.builder(
                      itemCount: productsOfOrder.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext _, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Card(
                              child: Container(
                            width: 110,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: const Border.fromBorderSide(
                                  BorderSide(color: CCColors.darkRed),
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      productsOfOrder[index].produtoPedido,
                                      style: CCStyles.size14DarkRedBold,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      Constant.quantidade,
                                      style: CCStyles.size14BlackBold,
                                    ),
                                    Text(
                                      productsOfOrder[index]
                                          .quantidadeProduto
                                          .toString(),
                                      style: CCStyles.size14BlackBold,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      Constant.status,
                                      style: CCStyles.size14BlackBold,
                                    ),
                                    statusPedido(productsOfOrder[index].status),
                                  ],
                                ),
                                Visibility(
                                  visible: productsOfOrder[index].status ==
                                              OrderStatus.pronto.value ||
                                          productsOfOrder[index].status ==
                                              OrderStatus.pendente.value
                                      ? true
                                      : false,
                                  child: const SizedBox(
                                    height: 16,
                                  ),
                                ),
                                Visibility(
                                  visible: productsOfOrder[index].status ==
                                          OrderStatus.pronto.value
                                      ? true
                                      : false,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: GestureDetector(
                                      onTap: () async {
                                        await orderProductController
                                            .alterarStatusDoProduto(
                                                productsOfOrder[index]
                                                    .idProdutoPedido,
                                                OrderStatus.entregue.value);
                                        listarProdutosDoPedido();
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 400,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: CCColors.darkRed,
                                        ),
                                        child: _isLoading
                                            ? const CircularProgressIndicator()
                                            : Text(
                                                "Marcar como entregue",
                                                style:
                                                    CCStyles.size14WhiteBold,
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: productsOfOrder[index].status ==
                                          OrderStatus.pendente.value
                                      ? true
                                      : false,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: GestureDetector(
                                      onTap: () async {
                                        await orderProductController
                                            .alterarStatusDoProduto(
                                                productsOfOrder[index]
                                                    .idProdutoPedido,
                                                OrderStatus.cancelado.value);
                                        listarProdutosDoPedido();
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 400,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: CCColors.darkRed,
                                        ),
                                        child: _isLoading
                                            ? const CircularProgressIndicator()
                                            : Text(
                                                "Cancelar",
                                                style:
                                                    CCStyles.size14WhiteBold,
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                        );
                      });
                }
              }
            })),
          ],
        ),
      ),
    );
  }
}
