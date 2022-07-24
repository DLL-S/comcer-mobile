// ignore_for_file: file_names



class User {
  String _usuario = '';
  String _senha = '';
  String _token = '';
  String _role = '';

  //Construtor
  User.auth(
    this._usuario,
    this._senha,
  );

  //Construtor Default
  User.empty();

  //Getters and Setters
  String get usuario => _usuario;

  set usuario(String value) {
    _usuario = value;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['usuario'] = _usuario;
    data['senha'] = _senha;
    data['token'] = _token;
    data['role'] = _role;
    return data;
  }
}
