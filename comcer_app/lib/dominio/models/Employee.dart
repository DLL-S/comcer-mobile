// ignore_for_file: file_names

import 'Address.dart';

class Employee {
  late int _id;
  late String _nome;
  late String _cpf;
  late String _dataNascimento;
  late String _celular;
  String? _email;
  late Address _endereco;
  late String _situacao;

  //Construtor default
  Employee.empty();

  //Construtor
  Employee(
    this._id,
    this._nome,
    this._cpf,
    this._dataNascimento,
    this._celular,
    this._email,
    this._endereco,
    this._situacao,
  );

  //Getters and Setters
  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get situacao => _situacao;

  set situacao(String value) {
    _situacao = value;
  }

  Address get endereco => _endereco;

  set endereco(Address value) {
    _endereco = value;
  }

  String? get email => _email;

  set email(String? value) {
    _email = value;
  }

  String get celular => _celular;

  set celular(String value) {
    _celular = value;
  }

  String get dataNascimento => _dataNascimento;

  set dataNascimento(String value) {
    _dataNascimento = value;
  }

  String get cpf => _cpf;

  set cpf(String value) {
    _cpf = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  //Converter JSON para classe
  Employee.fromJson(Map<String, dynamic> json) {
    _id = json["id"].toInt();
    _nome = json["nome"].toString();
    _cpf = json["cpf"].toString();
    _dataNascimento = json["dataNascimento"].toString();
    _celular = json["celular"].toString();
    _email = json["email"]?.toString();
    _endereco = ((json["endereco"] != null)
        ? Address.fromJson(json["endereco"])
        : null)!;
    _situacao = json["situacao"].toString();
  }

  //Converter classe para JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = _id;
    data["nome"] = _nome;
    data["cpf"] = _cpf;
    data["dataNascimento"] = _dataNascimento;
    data["celular"] = _celular;
    data["email"] = _email;
    if (_endereco != null) {
      data["endereco"] = _endereco.toJson();
    }
    data["situacao"] = _situacao;
    return data;
  }
}
