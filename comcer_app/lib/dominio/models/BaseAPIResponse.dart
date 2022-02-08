import 'package:comcer_app/dominio/models/Product.dart';
import 'package:comcer_app/dominio/models/inconsistencia_validacao.dart';

class BaseAPIResponse {
  List<Object>? resultados;
  List<InconsistenciaDeValidacao>? validacoes;
  bool? sucesso;
  int? pagina;
  int? quantidade;
  int? total;

  BaseAPIResponse(
      {List<Product>? resultados,
        List<InconsistenciaDeValidacao>? validacoes,
        bool? sucesso,
        int? pagina,
        int? quantidade,
        int? total});

  // BaseAPIResponse.fromJson(Map<String, dynamic> json) {
  //   if (json['resultados'] != null) {
  //     _resultados = <Object>[];
  //     json['resultados'].forEach((produto) {
  //       _resultados!.add(Product.fromJson(produto));
  //     });
  //   }
  //   if (json['validacoes'] != null) {
  //     _validacoes = <InconsistenciaDeValidacao>[];
  //     json['validacoes'].forEach((inconsistencia) {
  //       _validacoes!.add(InconsistenciaDeValidacao.fromJson(inconsistencia));
  //     });
  //   }
  //   _sucesso = json['sucesso'];
  //   _pagina = json['pagina'];
  //   _quantidade = json['quantidade'];
  //   _total = json['total'];
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   if (_resultados != null) {
  //     data['resultados'] = _resultados!.map((v) => v.toJson()).toList();
  //   }
  //   data['validacoes'] = _validacoes;
  //   data['sucesso'] = _sucesso;
  //   data['pagina'] = _pagina;
  //   data['quantidade'] = _quantidade;
  //   data['total'] = _total;
  //   return data;
  // }
}
