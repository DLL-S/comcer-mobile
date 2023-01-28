import 'dart:convert';
import 'dart:io';
import 'package:comcer_app/util/constants.dart';
import 'package:comcer_app/util/util.dart';
import 'package:http/http.dart' as http;
import 'package:comcer_app/environment_config.dart';
import 'package:comcer_app/model/api_response.dart';
import 'package:comcer_app/model/product.dart';

class ProductController {
  // static const String urlBase = Constant.localBaseUrl + "Produtos";

  //Listar Produtos
  Future<APIResponse<Product>> listarProdutos() {
    return http
        .get(Uri.https(EnvironmentConfig.urlsConfig(), "api/produtos"),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Bearer ${Util.getToken()}"
            })
        .then((data) {
          if (data.statusCode == 200) {
            final jsonData = jsonDecode(Utf8Decoder().convert(data.bodyBytes));
            var apiResponse = Product.empty();

            apiResponse = Product.fromJson(jsonData);

            return APIResponse<Product>(data: apiResponse);
          } else if (data.statusCode == 204) {
            return APIResponse<Product>(
                error: false,
                errorMessage: Constant.produtosVazio);
          } else if (data.statusCode == 401){
            return APIResponse<Product>(
                error: true,
                errorMessage: Constant.tokenExpirado);
          } else {
            return APIResponse<Product>(
                error: true,
                errorMessage: 'Erro: ' + data.statusCode.toString());
          }
        })
        .catchError((_) =>
            APIResponse<Product>(error: true, errorMessage: Constant.suporte))
        .timeout(const Duration(seconds: 25),
            onTimeout: () => APIResponse<Product>(
                error: true,
                errorMessage: Constant.suporte + 'Erro: Timed Out.'));
  }
}
