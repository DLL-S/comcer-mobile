import 'dart:convert';
import 'dart:io';

import 'package:comcer_app/dominio/models/ApiResponse.dart';
import 'package:comcer_app/dominio/models/order_product_response.dart';
import 'package:comcer_app/util/constant.dart';
import 'package:comcer_app/util/util.dart';
import 'package:http/http.dart' as http;

import '../environment_config.dart';

class OrderProductController {
  //Listar produtos do pedido
  Future<APIResponse<OrderProductResponse>> listarProdutosDoPedido(
      int idPedido) {
    return http
        .get(
            Uri.https(EnvironmentConfig.urlsConfig(),
                "api/produtosDoPedido/view/$idPedido"),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Bearer ${Util.token}"
            })
        .then((data) {
          if (data.statusCode == 200) {
            final jsonData = jsonDecode(Utf8Decoder().convert(data.bodyBytes));
            var apiResponse = OrderProductResponse.empty();

            apiResponse = OrderProductResponse.fromJsonResponse(jsonData);

            return APIResponse<OrderProductResponse>(data: apiResponse);
          } else if (data.statusCode == 204) {
            return APIResponse<OrderProductResponse>(
                error: false,
                errorMessage: 'Não há nenhum produto a ser exibido.');
          } else {
            return APIResponse<OrderProductResponse>(
                error: true,
                errorMessage: 'Erro: ' + data.statusCode.toString());
          }
        })
        .catchError((_) => APIResponse<OrderProductResponse>(
            error: true, errorMessage: Constant.suporte))
        .timeout(const Duration(seconds: 25),
            onTimeout: () => APIResponse<OrderProductResponse>(
                error: true,
                errorMessage: Constant.suporte + 'Erro: Timed Out.'));
  }

  //Alterar status do produto
  Future<APIResponse<bool>> alterarStatusDoProduto(int idProdutoPedido) {
    return http
        .put(
            Uri.https(EnvironmentConfig.urlsConfig(),
                "api/produtosDoPedido/$idProdutoPedido", {'status': '3'}),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Bearer ${Util.token}"
            })
        .then((data) {
          if (data.statusCode == 200) {
            return APIResponse<bool>(
                data: true,
                error: false,
                errorMessage: Constant.statusAlterado);
          } else if (data.statusCode == 204) {
            return APIResponse<bool>(
                error: false,
                errorMessage: Constant.produtosVazio);
          } else if (data.statusCode == 401) {
            return APIResponse<bool>(
                error: true,
                errorMessage: Constant.tokenExpirado);
          } else {
            return APIResponse<bool>(
                error: true,
                errorMessage: 'Erro: ' + data.statusCode.toString());
          }
        })
        .catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: Constant.suporte))
        .timeout(const Duration(seconds: 25),
            onTimeout: () => APIResponse<bool>(
                error: true,
                errorMessage: Constant.suporte + 'Erro: Timed Out.'));
  }
}
