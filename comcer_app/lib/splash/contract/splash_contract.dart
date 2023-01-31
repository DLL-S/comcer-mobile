abstract class SplashContractView {
  Future<bool> login();
  void redirectToLogin();
  void redirectToHome();
}

abstract class SplashContractPresenter {
  Future<bool> login();
}
