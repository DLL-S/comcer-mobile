import 'package:comcer_app/controller/order_product_controller.dart';
import 'package:comcer_app/core/app_colors.dart';
import 'package:comcer_app/core/app_styles.dart';
import 'package:comcer_app/dominio/models/ApiResponse.dart';
import 'package:comcer_app/dominio/models/order_product.dart';
import 'package:comcer_app/dominio/models/order_product_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ProducstOfOrderScreen extends StatefulWidget {
  final int? idPedido;

  const ProducstOfOrderScreen({Key? key, required this.idPedido}) : super(key: key);

  @override
  _ProducstOfOrderScreenState createState() => _ProducstOfOrderScreenState();
}

class _ProducstOfOrderScreenState extends State<ProducstOfOrderScreen> {

  final orderProductController = OrderProductController();
  APIResponse<OrderProductResponse> _apiResponse = APIResponse<OrderProductResponse>();
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
    _apiResponse = await orderProductController.listarProdutosDoPedido(widget.idPedido!);
    if (_apiResponse.data != null) {
      productsOfOrder = _apiResponse.data!.resultados as List<OrderProductResponse>;
    } else if (_apiResponse.error!) {
      hideLoading();
    }
    hideLoading();
  }

  @override
  void initState() {
    listarProdutosDoPedido();
  }

  @override
  Widget build(BuildContext context) {

    const String statusPendente = 'Pendente';
    const String statusCozinhando = 'Em preparo';
    const String statusPronto = 'Pronto';
    const String statusEntregue = 'Entregue';

    Widget statusPedido(int status) {
      if (status == 0) {
        return Text(
          statusPendente,
          style: TextStyle(
              color: AppColors.yellow,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        );
      } else if (status == 1) {
        return Text(
          statusCozinhando,
          style: TextStyle(
              color: AppColors.orange,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        );
      } else if (status == 2) {
        return Text(
          statusPronto,
          style: TextStyle(
              color: AppColors.green,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        );
      } else if (status == 3) {
        return Text(
          statusEntregue,
          style: TextStyle(
              color: AppColors.darkGreen,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        );
      } else {
        return const Text(
          'Status desconhecido',
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14),
        );
        ;
      }
    }

    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.darkRed, title: const Text('Produtos do Pedido'), centerTitle: true,),
      body: Container(
        color: AppColors.lightRed,
        child: Column(
          children: [
            Expanded(
                child: Builder(builder: (_) {
                  if(_isLoading){
                    return Center(child: CircularProgressIndicator(color: AppColors.darkRed,),);
                  } else {
                    if(_apiResponse.error!){
                      return Center(child: Text("Houve um problema ao carregar os dados do serviço.\n " + _apiResponse.errorMessage.toString(), style: AppStyles.size14BlackBold, textAlign: TextAlign.center,));
                    } else if(!_apiResponse.error! && productsOfOrder.isEmpty){
                      return Center(child: Text(_apiResponse.errorMessage.toString(), style: AppStyles.size14BlackBold, textAlign: TextAlign.center,));
                    } else {
                      return ListView.builder(
                          itemCount: productsOfOrder.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext _, int index){
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Card(
                                  child: Container(
                                    width: 110,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border.fromBorderSide(
                                          BorderSide(color: AppColors.darkRed),
                                        ),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(productsOfOrder[index].produtoPedido, style: AppStyles.size14DarkRedBold,),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text('Status: ', style: AppStyles.size14BlackBold,),
                                            statusPedido(productsOfOrder[index].status),
                                          ],
                                        ),
                                        Visibility(
                                          visible: productsOfOrder[index].status == 2 ? true : false,
                                          child: const SizedBox(
                                            height: 16,
                                          ),
                                        ),
                                        Visibility(
                                          visible: productsOfOrder[index].status == 2 ? true : false,
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 12),
                                            child: GestureDetector(
                                              onTap: () async {
                                                await orderProductController.alterarStatusDoProduto(productsOfOrder[index].idProdutoPedido);
                                                listarProdutosDoPedido();
                                              },
                                              child: Container(
                                                height: 40,
                                                width: 400,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: AppColors.darkRed,
                                                ),
                                                child: _isLoading ? CircularProgressIndicator() : Text(
                                                  "Marcar como entregue",
                                                  style: AppStyles.size14WhiteBold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                            );
                          }
                      );
                    }
                  }})
            ),
          ],
        ),
      ),
    );
  }
}
