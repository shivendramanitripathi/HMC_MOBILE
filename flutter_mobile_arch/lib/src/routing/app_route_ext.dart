enum AppRoute {
  splash('/splash', 'splash'),
  login('/login', 'login'),
  signUpSelection('/signUpSelection', 'signUpSelection'),
  signUp('/signUp', 'signUp'),
  otp('/otp', 'otp'),
  verifyByOtp('/verifyByOtp', 'verifyByOtp'),
  dashboard('/dashboard', 'dashboard'),
  barcode('/barcode', 'barcode'),
  formScreen('/formScreen', 'formScreen'),
  formList('formList', 'formList'),
  inAppPurchase('/inAppPurchase', 'inAppPurchase');

  final String path;
  final String name;

  const AppRoute(this.path, this.name);

  String get getPath => path;
  String get getName => name;
}
