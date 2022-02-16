// ignore_for_file: file_names

import 'package:comcer_app/dominio/enum/access_profile.dart';
import 'package:comcer_app/dominio/enum/situation.dart';
import 'package:comcer_app/dominio/models/Employee.dart';

class User{
  late final String _usuario;
  late final String _senha;
  late String _token = '';
  late String _role = '';

  //Construtor
  User.auth(this._usuario, this._senha,);

  //Construtor Default
  User.empty();

  //Getters and Setters
  String get email => _usuario;
  set email(String value) {
    _usuario = email;
  }

  String get senha => _senha;
  set senha(String value) {
    _senha = value;
  }

  String get token => _token;
  set token(String value) {
    _token = value;
  }

  String get role => _role;
  set role(String value) {
    _role = value;
  }

  User.fromJson(Map<String, dynamic> json) {
    _usuario = json['usuario'];
    _senha = json['senha'];
    _token = json['token'];
    _role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usuario'] = _usuario;
    data['senha'] = _senha;
    data['token'] = _token;
    data['role'] = _role;
    return data;
  }

}
