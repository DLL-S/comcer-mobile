import 'dart:convert';
import 'package:comcer_app/controller/order_resume_controller.dart';
import 'package:comcer_app/controller/product_controller.dart';
import 'package:comcer_app/core/app_colors.dart';
import 'package:comcer_app/core/app_styles.dart';
import 'package:comcer_app/dominio/models/api_response.dart';
import 'package:comcer_app/dominio/models/product.dart';
import 'package:comcer_app/dominio/models/table_model.dart';
import 'package:comcer_app/views/components/card/filter_card/fiter_card.dart';
import 'package:comcer_app/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoRequestScreen extends StatefulWidget {
  final Mesa table;

  const DoRequestScreen({Key? key, required this.table})
      : super(key: key);

  @override
  _DoRequestScreenState createState() => _DoRequestScreenState();
}

class _DoRequestScreenState extends State<DoRequestScreen> {
  late int quantity = 0;

  ProductController productController = ProductController();
  APIResponse<Product> _apiResponse = APIResponse<Product>();
  List<Product> _products = <Product>[];

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

  void buscaLista() async {
    showLoading();
    _apiResponse = await productController.listarProdutos();
    if (_apiResponse.data != null) {
      _products = _apiResponse.data!.resultados as List<Product>;
    } else if (_apiResponse.error!) {
      hideLoading();
    }
    hideLoading();
  }

  @override
  void initState() {
    buscaLista();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkRed,
        title: Text(Constant.mesa + widget.table.numero.toString()),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed('/resumo', arguments: widget.table);
        },
        child: const Icon(
          Icons.article_outlined,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        color: AppColors.lightRed,
        child: Column(
          children: [
            Visibility(
              visible: false,
              child: Container(
                margin: const EdgeInsets.symmetric(
                    vertical: Constant.DEFAULT_DISTANCE_BETWEEN_WIDGETS,
                    horizontal: 4),
                height: 25,
                child: Builder(builder: (_) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            const Center(
                                child: Text(Constant.filtros,
                                    style: TextStyle(
                                      color: AppColors.darkRed,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ))),
                            FilterCard(
                                filter: 'Bebidas',
                                color: Colors.blue,
                                isTapped: false,
                                onTap: () {}),
                            FilterCard(
                                filter: 'Entrada',
                                color: Colors.red,
                                isTapped: false,
                                onTap: () {}),
                            FilterCard(
                                filter: 'Menu Principal',
                                color: Colors.green,
                                isTapped: false,
                                onTap: () {}),
                            FilterCard(
                                filter: 'Sobremesa',
                                color: Colors.orange,
                                isTapped: false,
                                onTap: () {}),
                            FilterCard(
                                filter: 'Adicionais',
                                color: Colors.grey,
                                isTapped: false,
                                onTap: () {}),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
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
                } else if (!_apiResponse.error! && _products.isEmpty) {
                  return Center(
                      child: Text(
                    _apiResponse.errorMessage.toString(),
                    style: AppStyles.size14BlackBold,
                    textAlign: TextAlign.center,
                  ));
                } else {
                  context.watch<OrderResumeController>();
                  return ListView.builder(
                      itemCount: _products.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext _, int index) {
                        return Card(
                            child: GestureDetector(
                          onTap: () {
                            context
                                .read<OrderResumeController>()
                                .addToOrder(_products[index]);
                            Navigator.of(context).pushNamed('/resumo',
                                arguments: widget.table);
                          },
                          child: Container(
                            height: 100,
                            width: 110,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: const Border.fromBorderSide(
                                  BorderSide(color: AppColors.darkRed),
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 110,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.memory(
                                    base64Decode(_products[index].foto),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _products[index].nome,
                                      style: AppStyles.size14DarkRedBold,
                                    ),
                                    SizedBox(
                                        width: 230,
                                        child: Text(
                                          _products[index].descricao,
                                          style: AppStyles.size10BlackRegular,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.darkRed),
                                      child: Text(
                                        "R\$" +
                                            _products[index]
                                                .preco
                                                .toStringAsFixed(2)
                                                .replaceAll(".", ","),
                                        style: AppStyles.size12WhiteBold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ));
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
