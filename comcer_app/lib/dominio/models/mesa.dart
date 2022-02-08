import 'inconsistencia_validacao.dart';
import 'order_pad.dart';
import 'BaseAPIResponse.dart';

class Mesa extends BaseAPIResponse {
  late final int _id;
  late final int _numero;
  late final List<OrderPad>? _comandas;
  late final bool _disponivel;

  Mesa.empty();

  Mesa({int? id, int? numero, List<OrderPad>? orderPad, bool? disponivel}) {
    if (id != null) {
      _id = id;
    }
    if (numero != null) {
      _numero = numero;
    }
    if (orderPad != null) {
      _comandas = orderPad;
    }
    if (disponivel != null) {
      _disponivel = disponivel;
    }
  }

  int get id => _id;
  set id(int id) => _id = id;
  int get numero => _numero;
  set numero(int numero) => _numero = numero;
  List<OrderPad>? get comandas => _comandas;
  set comandas(List<OrderPad>? comandas) => _comandas = comandas;
  bool get disponivel => _disponivel;
  set disponivel(bool disponivel) => _disponivel = disponivel;

  Mesa.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _numero = json['numero'];
    if (json['comandas'] != null) {
      _comandas = <OrderPad>[];
      json['comandas'].forEach((v) {
        _comandas!.add(OrderPad.fromJson(v));
      });
    }
    _disponivel = json['disponivel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['numero'] = _numero;
    if (_comandas != null) {
      data['comandas'] = _comandas!.map((v) => v.toJson()).toList();
    }
    data['disponivel'] = _disponivel;
    return data;
  }

Mesa.fromJsonResponse(Map<String, dynamic> json) {
  if (json['resultados'] != null) {
    resultados = <Mesa>[];
    json['resultados'].forEach((mesa) {
      resultados!.add(Mesa.fromJson(mesa));
    });
  }
  if (json['validacoes'] != null) {
    validacoes = <InconsistenciaDeValidacao>[];
    json['validacoes'].forEach((inconsistencia) {
      validacoes!.add(InconsistenciaDeValidacao.fromJson(inconsistencia));
    });
  }
  sucesso = json['sucesso'];
  pagina = json['pagina'];
  quantidade = json['quantidade'];
  total = json['total'];
}

}
