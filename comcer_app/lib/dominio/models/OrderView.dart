import 'package:comcer_app/dominio/models/BaseAPIResponse.dart';
import 'package:comcer_app/dominio/models/order_product.dart';

import 'inconsistencia_validacao.dart';


class OrderView extends BaseAPIResponse {
  int? _numeroDaMesa;
  int? _numeroDoPedido;
  int? _statusDoPedido;


  OrderView.empty();

  OrderView(
      {int? numeroDaMesa,
        int? numeroDoPedido,
        int? statusDoPedido});

  int? get numeroDaMesa => _numeroDaMesa;
  set numeroDaMesa(int? numeroDaMesa) => _numeroDaMesa = numeroDaMesa;
  int? get numeroDoPedido => _numeroDoPedido;
  set numeroDoPedido(int? numeroDoPedido) => _numeroDoPedido = numeroDoPedido;
  int? get statusDoPedido => _statusDoPedido;
  set statusDoPedido(int? statusDoPedido) => _statusDoPedido = statusDoPedido;



  OrderView.fromJson(Map<String, dynamic> json) {
    numeroDaMesa = json['numeroMesa'];
    numeroDoPedido = json['numeroPedido'];
    statusDoPedido = json['statusPedido'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['numeroMesa'] = numeroDaMesa;
    data['numeroPedido'] = numeroDoPedido;
    data['statusPedido'] = statusDoPedido;
    return data;
  }

  OrderView.fromJsonResponse(Map<String, dynamic> json) {
    if (json['resultados'] != null) {
      resultados = <OrderView>[];
      json['resultados'].forEach((mesa) {
        resultados!.add(OrderView.fromJson(mesa));
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
