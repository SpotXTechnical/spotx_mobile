import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/local/shared_prefs_manager.dart';
import 'package:owner/data/remote/auth/i_auth_repository.dart';
import 'package:owner/presentation/auth/login/login_screen.dart';
import 'package:owner/presentation/main/main_screen.dart';
import 'package:owner/presentation/splash/bloc/splash_event.dart';
import 'package:owner/presentation/splash/bloc/splash_state.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  SplashBloc({required this.authRepository}) : super(const SplashState()) {
    on<CheckForceUpdate>(_checkForceUpdate);
  }
  final IAuthRepository authRepository;

  FutureOr<void> _checkForceUpdate(CheckForceUpdate event, Emitter<SplashState> emit) async {
    handleNavigation();
  }

  void handleNavigation() async {
    authRepository.updateFirebaseToken();
    if (await isLoggedInBefore()) {
      navigationKey.currentState?.pushReplacementNamed(MainScreen.tag);
    } else {
      navigationKey.currentState?.pushReplacementNamed(LoginScreen.tag);
    }
  }

  Future<bool> isLoggedInBefore() async {
    var loggedInCredentials = Injector().get<SharedPrefsManager>().credentials;
    debugPrint("logged in user: ${loggedInCredentials?.user?.name ?? ""}");
    debugPrint("is logged in before: ${loggedInCredentials != null}");
    return loggedInCredentials != null;
  }

  @override
  void onTransition(Transition<SplashEvent, SplashState> transition) {
    super.onTransition(transition);
    debugPrint(transition.toString());
  }
}
