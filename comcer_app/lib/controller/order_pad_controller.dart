import 'dart:convert';

import 'package:comcer_app/dominio/models/order.dart';
import 'package:comcer_app/dominio/models/order_pad.dart';
import 'package:comcer_app/dominio/models/order_product.dart';
import 'package:comcer_app/dominio/models/ApiResponse.dart';
import 'package:comcer_app/util/constant.dart';
import 'package:http/http.dart' as http;

class OrderPadController {

  static const String comanda = 'api/comanda';

  //Registrar Nova Comanda
  Future<APIResponse<bool>> addNewOrderPad(OrderPad orderPad) async {
    return await http
        .post(Uri.http(Constant.localBaseUrl, comanda), headers: Constant.headers, body: jsonEncode(orderPad.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'Não foi possível registrar o pedido na comanda!\nErro: ' + data.statusCode.toString(), data: false);
    }).catchError((_) =>
        APIResponse<bool>(error: true, errorMessage: Constant.suporte, data: false));
  }


  //Registrar pedido na comanda
  Future<APIResponse<bool>> addOrderInOrderPad(int id, Order order) async {
    return await http
        .put(Uri.http(Constant.localBaseUrl, comanda + '/' + id.toString()), headers: Constant.headers, body: jsonEncode(order.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'Não foi possível registrar o pedido na comanda! Erro: ' + data.statusCode.toString());
    }).catchError((_) =>
        APIResponse<bool>(error: true, errorMessage: Constant.suporte));
  }
}
