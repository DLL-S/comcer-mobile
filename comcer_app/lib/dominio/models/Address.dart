// ignore_for_file: file_names

class Address{
  late String _cep;
  late String _estado;
  late String _cidade;
  late String _bairro;
  late String _rua;
  late String _numero;
  String? _complemento;

  Address.empty();

  //Constructor
  Address(this._cep, this._estado, this._cidade, this._bairro, this._rua,
      this._numero, this._complemento);


  //Getters e Setters
  String get cep => _cep;
  set cep(String value) {
    _cep = value;
  }

  String? get complemento => _complemento;
  set complemento(String? value) {
    _complemento = value;
  }

  String get numero => _numero;
  set numero(String value) {
    _numero = value;
  }

  String get rua => _rua;
  set rua(String value) {
    _rua = value;
  }

  String get bairro => _bairro;
  set bairro(String value) {
    _bairro = value;
  }

  String get cidade => _cidade;
  set cidade(String value) {
    _cidade = value;
  }

  String get estado => _estado;
  set estado(String value) {
    _estado = value;
  }

  //Converter JSON para classe
  Address.fromJson(Map<String, dynamic> json) {
    _cep = json['cep'];
    _estado = json['estado'];
    _cidade = json['cidade'];
    _bairro = json['bairro'];
    _rua = json['rua'];
    _numero = json['numero'];
    _complemento = json['complemento'];
  }

  //Converter classe para JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cep'] = this._cep;
    data['estado'] = this._estado;
    data['cidade'] = this._cidade;
    data['bairro'] = this._bairro;
    data['rua'] = this._rua;
    data['numero'] = this._numero;
    data['complemento'] = this._complemento;
    return data;
  }


}
