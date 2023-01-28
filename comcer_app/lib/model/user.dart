import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  late String usuario;
  late String senha;
  late String token;
  late String role;

  User();

  User.auth(
    this.usuario,
    this.senha,
  );

  User.empty();

  factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);

  Map<String,dynamic> toJson() => _$UserToJson(this);
}
