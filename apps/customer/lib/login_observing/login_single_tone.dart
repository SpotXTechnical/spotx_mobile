import 'package:spotx/login_observing/login_observer.dart';

class LoginSingleTone {
  static final LoginSingleTone _loginSingleTone = LoginSingleTone._internal();
  final List<LoginObserver> loginObserverList = List.empty(growable: true);

  factory LoginSingleTone() {
    return _loginSingleTone;
  }

  LoginSingleTone._internal();

  void subscribe(LoginObserver observer) {
    loginObserverList.add(observer);
  }

  void unSubscribe(LoginObserver observer) {
    loginObserverList.removeWhere(
        (element) => element.observerName == observer.observerName);
  }

  void notify() {
    for (var element in loginObserverList) {
      element.update();
    }
  }
}