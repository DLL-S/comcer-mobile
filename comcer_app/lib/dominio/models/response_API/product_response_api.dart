import 'package:comcer_app/dominio/models/Product.dart';
import 'package:comcer_app/dominio/models/inconsistencia_validacao.dart';

class ProductAPIResponse {
  List<Product>? _produtos;
  List<InconsistenciaDeValidacao>? _validacoes;
  bool? _sucesso;
  int? _pagina;
  int? _quantidade;
  int? _total;

  ProductAPIResponse(
      {List<Product>? resultados,
        List<InconsistenciaDeValidacao>? validacoes,
        bool? sucesso,
        int? pagina,
        int? quantidade,
        int? total}) {
    if (produtos != null) {
      _produtos = produtos;
    }
    if (validacoes != null) {
      _validacoes = validacoes;
    }
    if (sucesso != null) {
      _sucesso = sucesso;
    }
    if (pagina != null) {
      _pagina = pagina;
    }
    if (quantidade != null) {
      _quantidade = quantidade;
    }
    if (total != null) {
      _total = total;
    }
  }

  List<Product>? get produtos => _produtos;
  set produtos(List<Product>? produtos) => _produtos = produtos;
  List<InconsistenciaDeValidacao>? get validacoes => _validacoes;
  set validacoes(List<InconsistenciaDeValidacao>? validacoes) => _validacoes = validacoes;
  bool? get sucesso => _sucesso;
  set sucesso(bool? sucesso) => _sucesso = sucesso;
  int? get pagina => _pagina;
  set pagina(int? pagina) => _pagina = pagina;
  int? get quantidade => _quantidade;
  set quantidade(int? quantidade) => _quantidade = quantidade;
  int? get total => _total;
  set total(int? total) => _total = total;

  ProductAPIResponse.fromJson(Map<String, dynamic> json) {
    if (json['resultados'] != null) {
      _produtos = <Product>[];
      json['resultados'].forEach((produto) {
        _produtos!.add(Product.fromJson(produto));
      });
    }
    if (json['validacoes'] != null) {
      _validacoes = <InconsistenciaDeValidacao>[];
      json['validacoes'].forEach((inconsistencia) {
        _validacoes!.add(InconsistenciaDeValidacao.fromJson(inconsistencia));
      });
    }
    _sucesso = json['sucesso'];
    _pagina = json['pagina'];
    _quantidade = json['quantidade'];
    _total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (_produtos != null) {
      data['resultados'] = _produtos!.map((v) => v.toJson()).toList();
    }
    data['validacoes'] = _validacoes;
    data['sucesso'] = _sucesso;
    data['pagina'] = _pagina;
    data['quantidade'] = _quantidade;
    data['total'] = _total;
    return data;
  }
}
