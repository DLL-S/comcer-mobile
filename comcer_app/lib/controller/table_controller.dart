import 'dart:convert';
import 'dart:io';

import 'package:comcer_app/dominio/models/api_response.dart';
import 'package:comcer_app/dominio/models/table_model.dart';
import 'package:comcer_app/util/constants.dart';
import 'package:comcer_app/util/util.dart';
import 'package:http/http.dart' as http;

import '../environment_config.dart';

class TableController {
  static const String defaultUrl = "api/mesa";

  //Listar Mesas
  Future<APIResponse<Mesa>> listarMesas() async {
    return http
        .get(Uri.https(EnvironmentConfig.urlsConfig(), "api/mesa"), headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${Util.getToken()}"
        })
        .then((data) {
          if (data.statusCode == 200) {
            final jsonData = jsonDecode(Utf8Decoder().convert(data.bodyBytes));
            var tablesResponse = Mesa.empty();

            tablesResponse = Mesa.fromJsonResponse(jsonData);

            return APIResponse<Mesa>(data: tablesResponse);
          } else if (data.statusCode == 204) {
            return APIResponse<Mesa>(
                error: false,
                errorMessage: Constant.mesaVazia);
          } else if (data.statusCode == 401) {
            return APIResponse<Mesa>(
                error: true,
                errorMessage: Constant.tokenExpirado);
          } else {
            return APIResponse<Mesa>(
                error: true,
                errorMessage: 'Erro: ' + data.statusCode.toString());
          }
        })
        .catchError((_) =>
            APIResponse<Mesa>(error: true, errorMessage: Constant.suporte))
        .timeout(const Duration(seconds: 30),
            onTimeout: () => APIResponse<Mesa>(
                error: true,
                errorMessage: Constant.suporte + 'Erro: Timed Out.'));
  }
}
