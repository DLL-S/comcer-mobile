import 'dart:convert';

import 'package:comcer_app/dominio/models/response_API/ApiResponse.dart';
import 'package:comcer_app/dominio/models/response_API/product_response_api.dart';
import 'package:comcer_app/util/constant.dart';
import 'package:http/http.dart' as http;

class ProductController {

  static const String urlBase = Constant.localBaseUrl + "Produtos";

  //Listar Produtos
  Future<APIResponse<ProductAPIResponse>> listarProdutos() {
    return http.get(Uri.http("189.123.152.249:5000", "api/produtos"), headers: Constant.headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(Utf8Decoder().convert(data.bodyBytes));
        var productsResponse = ProductAPIResponse();

        productsResponse = ProductAPIResponse.fromJson(jsonData);

        return APIResponse<ProductAPIResponse>(data: productsResponse);
      } else {
        return APIResponse<ProductAPIResponse>(
            error: true,
            errorMessage: 'Erro: Não foi possível carregar os produtos.' +
                data.statusCode.toString());
      }
    }).catchError((_) => APIResponse<ProductAPIResponse>(
        error: true, errorMessage: Constant.suporte));
  }





}
