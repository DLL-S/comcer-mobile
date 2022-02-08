// ignore_for_file: non_constant_identifier_names

import 'package:comcer_app/util/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class FuncionarioController {

  static const String urlBaseFuncionarios = Constant.localBaseUrl + "funcionarios/";

  FuncionarioController();

  //Listar todos os funcionários
  /*Future<APIResponse<List<Funcionario>>>? listarFuncionarios() {
    return http.get(Uri.parse(urlBaseFuncionarios + 'listar'), headers: Constantes.headers).then((data){
      if(data.statusCode == 200){
        final jsonData = json.decode(Utf8Decoder().convert(data.bodyBytes));
        final funcionarios = <Funcionario>[];

        for(var funcionario in jsonData) {
          funcionarios.add(Funcionario.fromJson(funcionario));
        }
        return APIResponse<List<Funcionario>>(data: funcionarios);
      }

    }).catchError((_) => APIResponse<List<Funcionario>>(
      error: true, errorMessage: "Não foi possível listar os funcionarios."));
  }*/

}
