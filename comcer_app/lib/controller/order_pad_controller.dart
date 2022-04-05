import 'dart:convert';
import 'dart:io';

import 'package:comcer_app/dominio/models/order.dart';
import 'package:comcer_app/dominio/models/order_pad.dart';
import 'package:comcer_app/dominio/models/order_product.dart';
import 'package:comcer_app/dominio/models/ApiResponse.dart';
import 'package:comcer_app/util/constant.dart';
import 'package:comcer_app/util/util.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class OrderPadController {

  static const String comanda = 'api/comanda';
  static const String adicionarComandaNaMesa = 'api/mesa/';
  static const String fecharComanda = 'api/mesa/encerrarComanda/';


  //Buscar comanda referente a mesa selecionada
  Future<APIResponse<OrderPad>> buscaComadaPorMesa(int tableNumber) {
    return http.get(Uri.http(Constant.localBaseUrl, "api/mesa/$tableNumber/comandas"), headers: {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer ${Util.getToken()}"}).then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(Utf8Decoder().convert(data.bodyBytes));
        var apiResponse = OrderPad.empty();

        apiResponse = OrderPad.fromJsonResponse(jsonData);

        return APIResponse<OrderPad>(data: apiResponse);
      } else if (data.statusCode == 204){
        return APIResponse<OrderPad>(
            error: false,
            errorMessage: 'Não há nenhum comanda vinculada a essa mesa.');
      } else {
        return APIResponse<OrderPad>(
            error: true,
            errorMessage: 'Erro: ' +
                data.statusCode.toString());
      }
    }).catchError((_) => APIResponse<OrderPad>(
        error: true, errorMessage: Constant.suporte))
        .timeout(const Duration(seconds: 25), onTimeout: () => APIResponse<OrderPad>(error: true, errorMessage: Constant.suporte + 'Erro: Timed Out.'));
  }

  //Registrar Nova Comanda
  Future<APIResponse<bool>> addNewOrderPad(OrderPad orderPad, int mesa) async {
    return await http
        .put(Uri.http(Constant.localBaseUrl, adicionarComandaNaMesa + "$mesa"), headers: {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer ${Util.getToken()}"}, body: jsonEncode(orderPad.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'Não foi possível abrir a comanda para a mesa e registrar o pedido!\nErro: ' + data.statusCode.toString(), data: false);
    }).catchError((_) =>
        APIResponse<bool>(error: true, errorMessage: Constant.suporte, data: false));
  }


  //Registrar um pedido em uma comanda aberta
  Future<APIResponse<bool>> addOrderInOrderPad(Order order, int numeroComanda) async {
    return await http
        .put(Uri.http(Constant.localBaseUrl, comanda + "/" + "$numeroComanda"), headers: {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer ${Util.getToken()}"}, body: jsonEncode(order.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'Não foi possível registrar o pedido na comanda! Erro: ' + data.statusCode.toString());
    }).catchError((_) =>
        APIResponse<bool>(error: true, errorMessage: Constant.suporte));
  }

  //Fechar Comanda
  Future<APIResponse<bool>> closeOrderPad(int numeroComanda) async {
    return await http
        .put(Uri.http(Constant.localBaseUrl, fecharComanda + "$numeroComanda"), headers: {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer ${Util.getToken()}"})
        .then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'Não foi possível fechar a comanda! Erro: ' + data.statusCode.toString());
    }).catchError((_) =>
        APIResponse<bool>(error: true, errorMessage: Constant.suporte));
  }
}
