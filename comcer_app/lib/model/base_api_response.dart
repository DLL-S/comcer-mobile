import 'package:json_annotation/json_annotation.dart';
import 'inconsistencies.dart';

part 'base_api_response.g.dart';

@JsonSerializable()
class BaseAPIResponse {
  List<Object>? resultados;
  List<InconsistenciaDeValidacao>? validacoes;
  bool? sucesso;
  int? pagina;
  int? quantidade;
  int? total;

  BaseAPIResponse({
    this.resultados,
    this.validacoes,
    this.sucesso,
    this.pagina,
    this.quantidade,
    this.total
    }
  );

  factory BaseAPIResponse.fromJson(Map<String,dynamic> json) => _$BaseAPIResponseFromJson(json);

  Map<String,dynamic> toJson() => _$BaseAPIResponseToJson(this);
}
