import 'package:comcer_app/dominio/enum/environment.dart';
import 'package:comcer_app/util/constant.dart';

class EnvironmentConfig {
  static Environments? environmentBuild;

  static String urlsConfig() {
    switch(environmentBuild) {
      case Environments.DESENVOLVIMENTO:
        return Constant.localBaseUrlDev;
      case Environments.PRODUCAO:
        return Constant.localBaseUrlProd;
      default:
        return Constant.localBaseUrlProd;
    }
  }
}
