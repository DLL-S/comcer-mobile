import 'dart:convert';
import 'dart:io';

import 'package:comcer_app/environment_config.dart';
import 'package:comcer_app/dominio/models/ApiResponse.dart';
import 'package:comcer_app/dominio/models/OrderView.dart';
import 'package:comcer_app/util/constant.dart';
import 'package:comcer_app/util/util.dart';
import 'package:http/http.dart' as http;

class OrderController {
  //Listar Pedidos
  Future<APIResponse<OrderView>> listarPedidos() {
    return http
        .get(Uri.https(EnvironmentConfig.urlsConfig(), "api/pedidos/view"),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Bearer ${Util.token}"
            })
        .then((data) {
          if (data.statusCode == 200) {
            final jsonData = jsonDecode(Utf8Decoder().convert(data.bodyBytes));
            var apiResponse = OrderView.empty();

            apiResponse = OrderView.fromJsonResponse(jsonData);

            return APIResponse<OrderView>(data: apiResponse);
          } else if (data.statusCode == 204) {
            return APIResponse<OrderView>(
                error: false,
                errorMessage: 'Não há nenhum pedido a ser exibido.');
          } else {
            return APIResponse<OrderView>(
                error: true,
                errorMessage: 'Erro: ' + data.statusCode.toString());
          }
        })
        .catchError((_) =>
            APIResponse<OrderView>(error: true, errorMessage: Constant.suporte))
        .timeout(const Duration(seconds: 25),
            onTimeout: () => APIResponse<OrderView>(
                error: true,
                errorMessage: Constant.suporte + 'Erro: Timed Out.'));
  }
}
