import 'package:comcer_app/controller/order_product_controller.dart';
import 'package:comcer_app/core/app_colors.dart';
import 'package:comcer_app/core/app_styles.dart';
import 'package:comcer_app/dominio/enum/order_status.dart';
import 'package:comcer_app/dominio/models/api_response.dart';
import 'package:comcer_app/dominio/models/order_product_response.dart';
import 'package:comcer_app/util/constants.dart';
import 'package:flutter/material.dart';

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
      if (status == OrderStatus.PENDENTE.value) {
        return const Text(
          Constant.statusPendente,
          style: TextStyle(
              color: AppColors.yellow,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        );
      } else if (status == OrderStatus.COZINHANDO.value) {
        return const Text(
          Constant.statusCozinhando,
          style: TextStyle(
              color: AppColors.orange,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        );
      } else if (status == OrderStatus.PRONTO.value) {
        return const Text(
          Constant.statusPronto,
          style: TextStyle(
              color: AppColors.green,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        );
      } else if (status == OrderStatus.ENTREGUE.value) {
        return const Text(
          Constant.statusEntregue,
          style: TextStyle(
              color: AppColors.darkGreen,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        );
      } else if (status == OrderStatus.CANCELADO.value) {
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
        backgroundColor: AppColors.darkRed,
        title: const Text(Constant.produtosDoPedido),
        centerTitle: true,
      ),
      body: Container(
        color: AppColors.lightRed,
        child: Column(
          children: [
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
                } else if (!_apiResponse.error! && productsOfOrder.isEmpty) {
                  return Center(
                      child: Text(
                    _apiResponse.errorMessage.toString(),
                    style: AppStyles.size14BlackBold,
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
                                  BorderSide(color: AppColors.darkRed),
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
                                      style: AppStyles.size14DarkRedBold,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      Constant.quantidade,
                                      style: AppStyles.size14BlackBold,
                                    ),
                                    Text(
                                      productsOfOrder[index]
                                          .quantidadeProduto
                                          .toString(),
                                      style: AppStyles.size14BlackBold,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      Constant.status,
                                      style: AppStyles.size14BlackBold,
                                    ),
                                    statusPedido(productsOfOrder[index].status),
                                  ],
                                ),
                                Visibility(
                                  visible: productsOfOrder[index].status ==
                                              OrderStatus.PRONTO.value ||
                                          productsOfOrder[index].status ==
                                              OrderStatus.PENDENTE.value
                                      ? true
                                      : false,
                                  child: const SizedBox(
                                    height: 16,
                                  ),
                                ),
                                Visibility(
                                  visible: productsOfOrder[index].status ==
                                          OrderStatus.PRONTO.value
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
                                                OrderStatus.ENTREGUE.value);
                                        listarProdutosDoPedido();
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 400,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.darkRed,
                                        ),
                                        child: _isLoading
                                            ? const CircularProgressIndicator()
                                            : Text(
                                                "Marcar como entregue",
                                                style:
                                                    AppStyles.size14WhiteBold,
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: productsOfOrder[index].status ==
                                          OrderStatus.PENDENTE.value
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
                                                OrderStatus.CANCELADO.value);
                                        listarProdutosDoPedido();
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 400,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.darkRed,
                                        ),
                                        child: _isLoading
                                            ? const CircularProgressIndicator()
                                            : Text(
                                                "Cancelar",
                                                style:
                                                    AppStyles.size14WhiteBold,
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
