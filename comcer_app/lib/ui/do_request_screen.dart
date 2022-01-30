import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:comcer_app/controller/product_controller.dart';
import 'package:comcer_app/core/app_colors.dart';
import 'package:comcer_app/core/app_styles.dart';
import 'package:comcer_app/dominio/models/response_API/ApiResponse.dart';
import 'package:comcer_app/dominio/models/response_API/product_response_api.dart';
import 'package:comcer_app/ui/components/card/filter_card/fiter_card.dart';
import 'package:comcer_app/ui/components/card/product_card/product_card.dart';
import 'package:comcer_app/util/constant.dart';
import 'package:comcer_app/util/util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class DoRequestScreen extends StatefulWidget {

  final String tableNumber;

  const DoRequestScreen({Key? key, required this.tableNumber}) : super(key: key);

  @override
  _DoRequestScreenState createState() => _DoRequestScreenState();
}

class _DoRequestScreenState extends State<DoRequestScreen> {

  ProductController productController = ProductController();
  APIResponse<ProductAPIResponse> _apiResponse = APIResponse<ProductAPIResponse>();
  ProductAPIResponse _products = ProductAPIResponse();

  Future<File> testeDecode (String image64, String nomeDoProduto) async {
    final decodedBytes = base64Decode(image64);
    final directory = await getApplicationDocumentsDirectory();
    var fileImage = File(nomeDoProduto + "_imagem.png");
    fileImage.writeAsBytesSync(List.from(decodedBytes));
    return fileImage;
  }

  bool _isLoading = false;

  void showLoading(){
    setState(() {
      _isLoading = true;
    });
  }
  void hideLoading(){
    setState(() {
      _isLoading = false;
    });
  }


  void buscaLista() async {
    showLoading();
    _apiResponse = await productController.listarProdutos();
    _products = _apiResponse.data!;
    hideLoading();
  }


  @override
  void initState() {
    buscaLista();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.darkRed, title: Text("Mesa " + widget.tableNumber), centerTitle: true,),
      body: Container(
          color: AppColors.lightRed,
        child: Column(
          children: [
            Visibility(
              visible: _isLoading ? false : true,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: Constant.DEFAULT_DISTANCE_BETWEEN_WIDGETS, horizontal: 4),
                height: 25,
                child: Builder(
                  builder: (_) {
                    return _isLoading ? CircularProgressIndicator(color: AppColors.darkRed) : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: [
                                Center(child: Text("Filtros:", style: TextStyle(color: AppColors.darkRed, fontSize: 14, fontWeight: FontWeight.bold,))),
                                FilterCard(filter: 'Bebidas', color: Colors.blue, isTapped: false ,onTap: (){}),
                                FilterCard(filter: 'Entrada', color: Colors.red, isTapped: false ,onTap: (){}),
                                FilterCard(filter: 'Menu Principal', color: Colors.green, isTapped: false ,onTap: (){}),
                                FilterCard(filter: 'Sobremesa', color: Colors.orange, isTapped: false ,onTap: (){}),
                                FilterCard(filter: 'Adicionais', color: Colors.grey, isTapped: false ,onTap: (){}),
                              ],
                            ),
                        ),
                      ],
                    );
                  }
                ),
              ),
            ),
            Expanded(
                child: Builder(builder: (_) {
                  if(_isLoading){
                    return Center(child: CircularProgressIndicator(color: AppColors.darkRed,),);
                  } else {
                    return ListView.builder(
                        itemCount: _products.quantidade ?? 0,
                        itemBuilder: (BuildContext _, int index){
                          return Card(
                           child: GestureDetector(
                             onTap: (){},
                             child: Container(
                               height: 100,
                               width: 110,
                               padding: EdgeInsets.all(8),
                               decoration: BoxDecoration(
                                   border: Border.fromBorderSide(
                                     BorderSide(color: AppColors.darkRed),
                                   ),
                                   color: Colors.white,
                                   borderRadius: BorderRadius.circular(10)),
                               child: Row(
                                 crossAxisAlignment: CrossAxisAlignment.stretch,
                                 children: [
                                   Container(
                                     width: 110,
                                     height: 80,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(10),
                                       border: Border.fromBorderSide(BorderSide(color: AppColors.darkRed)),
                                       color: Colors.grey,
                                     ),
                                     child: Image.memory(base64Decode(_products.produtos![index].foto), fit: BoxFit.cover, ),
                                   ),
                                   const SizedBox(
                                     width: 16,
                                   ),
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text(_products.produtos![index].nome, style: AppStyles.size18DarkRedBold,),
                                       SizedBox(
                                           width: 180,
                                           child: Text(_products.produtos![index].descricao + "texto para ultrapassar o tamanho limite e verificar o funcionamento da ellipsis",
                                             style: AppStyles.size10BlackRegular,
                                             maxLines: 2, overflow: TextOverflow.ellipsis,)
                                       ),
                                       const SizedBox(
                                         height: 8,
                                       ),
                                       Container(
                                         padding: EdgeInsets.all(5),
                                         decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(10),
                                             color: AppColors.darkRed
                                         ),
                                         child: Text("R\$" + Util.formataValorProdutoParaBR(_products.produtos![index].preco), style: AppStyles.size12WhiteBold,),
                                       ),
                                     ],
                                   )
                                 ],
                               ),
                             ),
                           )
                          );
                        }
                    );
                  }
                })
            ),
            Visibility(
              visible: _isLoading ? false : true,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16, left: 8, right: 8),
                child: GestureDetector(
                  onTap: (){},
                  child: Container(
                    height: 40,
                    width: 400,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.darkRed,
                    ),
                    child: Text("Confirmar Pedido", style: AppStyles.size22WhiteBold,),
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
