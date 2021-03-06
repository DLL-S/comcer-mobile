import 'dart:convert';

import 'package:comcer_app/dominio/models/api_response.dart';
import 'package:comcer_app/dominio/models/user.dart';
import 'package:comcer_app/util/constants.dart';
import 'package:http/http.dart' as http;

import '../environment_config.dart';

class UserController {
  static String login = 'Api/login';

  //Autenticar usuário
  Future<APIResponse<User>> autenticar(User user) {
    return http
        .post(Uri.https(EnvironmentConfig.urlsConfig(), login),
            headers: Constant.headers, body: jsonEncode(user.toJson()))
        .then((data) {
          if (data.statusCode == 200) {
            final jsonData =
                jsonDecode(const Utf8Decoder().convert(data.bodyBytes));
            var apiResponse = User.empty();

            apiResponse = User.fromJson(jsonData);

            return APIResponse<User>(data: apiResponse);
          } else if (data.statusCode == 400) {
            final jsonData =
            jsonDecode(const Utf8Decoder().convert(data.bodyBytes));
            return APIResponse<User>(
                error: true,
                errorMessage:
                    jsonData['message'].toString());
          } else {
            final jsonData =
            jsonDecode(const Utf8Decoder().convert(data.bodyBytes));
            return APIResponse<User>(
                error: true,
                errorMessage: 'Erro: ' + jsonData['message'].toString());
          }
        })
        .catchError((_) =>
            APIResponse<User>(error: true, errorMessage: Constant.suporte))
        .timeout(const Duration(seconds: 25),
            onTimeout: () => APIResponse<User>(
                error: true,
                errorMessage: Constant.suporte + 'Erro: Timed Out.'));
  }
}
