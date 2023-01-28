import 'package:comcer_app/util/constants.dart';
import 'enum/environment.dart';

class EnvironmentConfig {
  static Environments? environmentBuild;

  static String urlsConfig() {
    switch (environmentBuild) {
      case Environments.desenvolvimento:
        return Constant.localBaseUrlDev;
      case Environments.producao:
        return Constant.localBaseUrlProd;
      default:
        return Constant.localBaseUrlProd;
    }
  }
}
