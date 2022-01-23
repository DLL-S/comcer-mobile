// ignore_for_file: file_names

import 'package:comcer_app/dominio/enum/access_profile.dart';
import 'package:comcer_app/dominio/enum/situation.dart';
import 'package:comcer_app/dominio/models/Employee.dart';

class User{
  late int _id;
  late Employee _funcionario;
  late String _senha;
  late AccessProfile _perfilDeAcesso;
  late bool _administrador;
  late Situation _situacao;

  //Construtor
  User(this._id, this._funcionario, this._senha, this._perfilDeAcesso,
      this._administrador, this._situacao);

  //Construtor Default
  User.empty();

  //Getters and Setters
  int get id => _id;
  set id(int value) {
    _id = value;
  }

  Situation get situacao => _situacao;
  set situacao(Situation value) {
    _situacao = value;
  }

  bool get administrador => _administrador;
  set administrador(bool value) {
    _administrador = value;
  }

  AccessProfile get perfilDeAcesso => _perfilDeAcesso;
  set perfilDeAcesso(AccessProfile value) {
    _perfilDeAcesso = value;
  }

  String get senha => _senha;
  set senha(String value) {
    _senha = value;
  }

  Employee get funcionario => _funcionario;
  set funcionario(Employee value) {
    _funcionario = value;
  }

}
