// ignore_for_file: file_names

import 'package:comcer_app/dominio/enumeradores/PerfilDeAcesso.dart';
import 'package:comcer_app/dominio/enumeradores/Situacao.dart';
import 'package:comcer_app/dominio/models/Funcionario.dart';

class Usuario{
  late int _id;
  late Funcionario _funcionario;
  late String _senha;
  late PerfilDeAcesso _perfilDeAcesso;
  late bool _administrador;
  late Situacao _situacao;

  //Construtor
  Usuario(this._id, this._funcionario, this._senha, this._perfilDeAcesso,
      this._administrador, this._situacao);

  //Construtor Default
  Usuario.vazio();

  //Getters and Setters
  int get id => _id;
  set id(int value) {
    _id = value;
  }

  Situacao get situacao => _situacao;
  set situacao(Situacao value) {
    _situacao = value;
  }

  bool get administrador => _administrador;
  set administrador(bool value) {
    _administrador = value;
  }

  PerfilDeAcesso get perfilDeAcesso => _perfilDeAcesso;
  set perfilDeAcesso(PerfilDeAcesso value) {
    _perfilDeAcesso = value;
  }

  String get senha => _senha;
  set senha(String value) {
    _senha = value;
  }

  Funcionario get funcionario => _funcionario;
  set funcionario(Funcionario value) {
    _funcionario = value;
  }

}
