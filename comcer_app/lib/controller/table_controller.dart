import 'dart:convert';
import 'dart:io';

import 'package:comcer_app/dominio/models/mesa.dart';
import 'package:comcer_app/dominio/models/ApiResponse.dart';
import 'package:comcer_app/dominio/models/BaseAPIResponse.dart';
import 'package:comcer_app/service/prefs_service.dart';
import 'package:comcer_app/util/constant.dart';
import 'package:comcer_app/util/util.dart';
import 'package:http/http.dart' as http;

class TableController {

  static const String defaultUrl = "api/mesa";


  //Listar Mesas
  Future<APIResponse<Mesa>> listarMesas() {
    return http.get(Uri.http(Constant.localBaseUrl, "api/mesa"), headers: {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer ${Util.token}"}).then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(Utf8Decoder().convert(data.bodyBytes));
        var tablesResponse = Mesa.empty();

        tablesResponse = Mesa.fromJsonResponse(jsonData);

        return APIResponse<Mesa>(data: tablesResponse);
      } else if (data.statusCode == 204){
        return APIResponse<Mesa>(
            error: false,
            errorMessage: 'Não há nenhuma mesa a ser exibida.');
      } else {
        return APIResponse<Mesa>(
            error: true,
            errorMessage: 'Erro: ' +
                data.statusCode.toString());
      }
    }).catchError((_) => APIResponse<Mesa>(
        error: true, errorMessage: Constant.suporte))
        .timeout(const Duration(seconds: 30), onTimeout: () => APIResponse<Mesa>(error: true, errorMessage: Constant.suporte + 'Erro: Timed Out.'));
  }

}
