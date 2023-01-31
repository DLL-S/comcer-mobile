import 'package:comcer_app/splash/contract/splash_contract.dart';

class SplashPresenterImpl implements SplashContractPresenter {
  final SplashContractView _view;

  SplashPresenterImpl(
      this._view
  );

  @override
  Future<bool> login() async {
    return await _view.login() ? true : false;
  }

}
