import 'package:json_annotation/json_annotation.dart';

part 'inconsistencies.g.dart';

@JsonSerializable()
class InconsistenciaDeValidacao {
  late String propriedade;
  late String mensagem;
  late bool impedidtivo;

  InconsistenciaDeValidacao.vazio();

  InconsistenciaDeValidacao({
    required this.propriedade,
    required this.mensagem,
    required this.impedidtivo
    }
  );

  factory InconsistenciaDeValidacao.fromJson(Map<String,dynamic> json) => _$InconsistenciaDeValidacaoFromJson(json);

  Map<String,dynamic> toJson() => _$InconsistenciaDeValidacaoToJson(this);
}
