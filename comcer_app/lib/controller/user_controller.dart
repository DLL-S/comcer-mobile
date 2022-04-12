import 'dart:convert';

import 'package:comcer_app/dominio/models/ApiResponse.dart';
import 'package:comcer_app/dominio/models/User.dart';
import 'package:comcer_app/util/constant.dart';
import 'package:http/http.dart' as http;

import '../Environment_config.dart';

class UserController {

  static String login = 'Api/login';


  //Autenticar usuário
  Future<APIResponse<User>> autenticar(User user) {
    return http.post(Uri.https(EnvironmentConfig.urlsConfig(), login), headers: Constant.headers, body: jsonEncode(user.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(const Utf8Decoder().convert(data.bodyBytes));
        var apiResponse = User.empty();

        apiResponse = User.fromJson(jsonData);

        return APIResponse<User>(data: apiResponse);
      } else if (data.statusCode == 400){
        return APIResponse<User>(
            error: true,
            errorMessage: 'E-mail ou senha incorretos, por favor verifique os dados.');
      } else {
        return APIResponse<User>(
            error: true,
            errorMessage: 'Erro: ' +
                data.statusCode.toString());
      }
    }).catchError((_) => APIResponse<User>(
        error: true, errorMessage: Constant.suporte))
        .timeout(const Duration(seconds: 25), onTimeout: () => APIResponse<User>(error: true, errorMessage: Constant.suporte + 'Erro: Timed Out.'));
  }

}
