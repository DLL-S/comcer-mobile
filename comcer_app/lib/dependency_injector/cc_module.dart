import 'package:comcer_app/splash/contract/splash_contract.dart';
import 'package:get_it/get_it.dart';

import '../splash/presenter/splash_presenter.dart';

final getIt = GetIt.instance;

class CCModule {
  CCModule._();

  static const scopeName = "CCModule";

  static void init() {
    if (getIt.currentScopeName != scopeName) {
      getIt.pushNewScope(
        scopeName: scopeName,
        init: (getIt) {
          getIt.registerFactoryParam<SplashContractPresenter,
              SplashContractView, void>(
                  (view, _) => SplashPresenterImpl(view));
        }
      );
    }
  }
}
