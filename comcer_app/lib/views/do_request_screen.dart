import 'dart:convert';
import 'package:comcer_app/controller/order_resume_controller.dart';
import 'package:comcer_app/controller/product_controller.dart';
import 'package:comcer_app/core/app_colors.dart';
import 'package:comcer_app/core/app_styles.dart';
import 'package:comcer_app/views/components/card/filter_card/fiter_card.dart';
import 'package:comcer_app/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/api_response.dart';
import '../model/product.dart';
import '../model/table.dart';

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
  TextEditingController searchController = TextEditingController();
  APIResponse<Product> _apiResponse = APIResponse<Product>();
  List<Product> _products = <Product>[];
  List<Product> _allProducts = <Product>[];

  bool _isLoading = false;
  bool _isSearching = false;

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
      _products.sort((a, b) => a.nome.toLowerCase().compareTo(b.nome.toLowerCase()));
      _allProducts = _products;
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
        title: _isSearching ? Container(
          height: 35,
          padding: const EdgeInsets.all(4),
          decoration:const  BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          child: TextField(
            controller: searchController,
            cursorColor: Colors.black,
            autofocus: true,
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)
              ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                )
            ),
            onChanged: (string){
              setState(() {
                _products = _products.where((element) => element.nome.toLowerCase().contains(string.toLowerCase())).toList();
                if (string.isEmpty){
                  _products = _allProducts;
                }
              });
            },
          ),
        ) : Text(Constant.mesa + widget.table.numero.toString()),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: IconButton(
              icon: _isSearching ? const Icon(Icons.close, color: AppColors.white,) : const Icon(Icons.search, color: AppColors.white,),
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                  if (!_isSearching){
                    _products = _allProducts;
                    searchController.text = "";
                  }
                });
              },
            ),
          )
        ],
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
                    "Nenhum produto encontrado...",
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
                            height: 110,
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
                                  height: 70,
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
                                    Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: SizedBox(
                                        width: 230,
                                        child: Text(
                                          _products[index].nome,
                                          maxLines: 2,
                                          style: AppStyles.size14DarkRedBold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: SizedBox(
                                          width: 230,
                                          child: Text(
                                            _products[index].descricao,
                                            style: AppStyles.size10BlackRegular,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(4),
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
                                        style: AppStyles.size14WhiteBold,
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
