// ignore_for_file: file_names



class InconsistenciaDeValidacao {
  late String _propriedade;
  late String _mensagem;
  late bool _impedidtivo;

  //Construtor default
  InconsistenciaDeValidacao.vazio();

  //Construtor
  InconsistenciaDeValidacao(
      this._propriedade, this._mensagem, this._impedidtivo);

  //Getters and Setters
  String get propriedade => _propriedade;

  set propriedade(String value) {
    _propriedade = value;
  }

  String get mensagem => _mensagem;

  set mensagem(String value) {
    _mensagem = value;
  }

  bool get impedidtivo => _impedidtivo;

  set impeditivo(bool value) {
    _impedidtivo = value;
  }

  //Converter JSON para classe
  InconsistenciaDeValidacao.fromJson(Map<String, dynamic> json) {
    _propriedade = json["propriedade"].toString();
    _mensagem = json["mensagem"].toString();
    _impedidtivo = json[""] == 1;
  }

  //Converter classe para JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["propriedade"] = _propriedade;
    data["mensagem"] = _mensagem;
    data["impeditivo"] = _impedidtivo ? 1 : 0;
    return data;
  }
}
