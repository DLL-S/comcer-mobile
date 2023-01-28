import 'dart:convert';
import 'dart:io';
import 'package:comcer_app/util/constants.dart';
import 'package:comcer_app/util/util.dart';
import 'package:http/http.dart' as http;
import '../environment_config.dart';
import '../model/api_response.dart';
import '../model/order.dart';
import '../model/order_pad.dart';

class OrderPadController {
  static const String comanda = 'api/comanda';
  static const String adicionarComandaNaMesa = 'api/mesa/';
  static const String fecharComanda = 'api/mesa/encerrarComanda/';
  var paraPagamento = {'paraPagamento' : 'true'};

  //Buscar comanda referente a mesa selecionada
  Future<APIResponse<OrderPad>> buscaComadaPorMesa(int tableNumber) {
    return http
        .get(
            Uri.https(EnvironmentConfig.urlsConfig(),
                "api/mesa/$tableNumber/comandas"),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Bearer ${Util.getToken()}"
            })
        .then((data) {
          if (data.statusCode == 200) {
            final jsonData = jsonDecode(Utf8Decoder().convert(data.bodyBytes));
            var apiResponse = OrderPad.empty();

            apiResponse = OrderPad.fromJson(jsonData);

            return APIResponse<OrderPad>(data: apiResponse);
          } else if (data.statusCode == 204) {
            return APIResponse<OrderPad>(
                error: false,
                errorMessage: 'Não há nenhum comanda vinculada a essa mesa.');
          } else if (data.statusCode == 401) {
            return APIResponse<OrderPad>(
                error: true, errorMessage: Constant.tokenExpirado);
          } else {
            return APIResponse<OrderPad>(
                error: true,
                errorMessage: 'Erro: ' + data.statusCode.toString());
          }
        })
        .catchError((_) =>
            APIResponse<OrderPad>(error: true, errorMessage: Constant.suporte))
        .timeout(const Duration(seconds: 25),
            onTimeout: () => APIResponse<OrderPad>(
                error: true,
                errorMessage: Constant.suporte + 'Erro: Timed Out.'));
  }

  //Registrar Nova Comanda
  Future<APIResponse<bool>> addNewOrderPad(OrderPad orderPad, int mesa) async {
    return await http
        .put(
            Uri.https(EnvironmentConfig.urlsConfig(),
                adicionarComandaNaMesa + "$mesa"),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Bearer ${Util.getToken()}"
            },
            body: jsonEncode(orderPad.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      } else if (data.statusCode == 401) {
        return APIResponse<bool>(
            error: true, errorMessage: Constant.tokenExpirado, data: false);
      } else {
        return APIResponse<bool>(
            error: true,
            errorMessage:
                'Não foi possível abrir a comanda para a mesa e registrar o pedido!\nErro: ' +
                    data.statusCode.toString(),
            data: false);
      }
    }).catchError((_) => APIResponse<bool>(
            error: true, errorMessage: Constant.suporte, data: false));
  }

  //Registrar um pedido em uma comanda aberta
  Future<APIResponse<bool>> addOrderInOrderPad(
      Order order, int numeroComanda) async {
    return await http
        .put(
            Uri.https(EnvironmentConfig.urlsConfig(),
                comanda + "/" + "$numeroComanda"),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Bearer ${Util.getToken()}"
            },
            body: jsonEncode(order.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      } else if (data.statusCode == 401) {
        return APIResponse<bool>(
            error: true, errorMessage: Constant.tokenExpirado);
      } else {
        return APIResponse<bool>(
            error: true,
            errorMessage:
                'Não foi possível registrar o pedido na comanda! Erro: ' +
                    data.statusCode.toString());
      }
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: Constant.suporte));
  }

  //Fechar Comanda
  Future<APIResponse<bool>> closeOrderPad(int numeroComanda) async {
    return await http.put(
        Uri.https(EnvironmentConfig.urlsConfig(),
            fecharComanda + "$numeroComanda", paraPagamento),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${Util.getToken()}"
        }).then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      } else if (data.statusCode == 401) {
        return APIResponse<bool>(
            error: true, errorMessage: Constant.tokenExpirado);
      } else {
        return APIResponse<bool>(
            error: true,
            errorMessage: 'Não foi possível fechar a comanda! Erro: ' +
                data.statusCode.toString());
      }
    }).catchError(
        (_) => APIResponse<bool>(error: true, errorMessage: Constant.suporte));
  }
}
