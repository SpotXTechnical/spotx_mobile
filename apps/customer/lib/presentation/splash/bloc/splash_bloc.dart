import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/auth/i_auth_repository.dart';
import 'package:spotx/data/remote/auth/models/force_update_entity.dart';
import 'package:spotx/data/remote/auth/services/force_update_service.dart';
import 'package:spotx/presentation/main/main_screen.dart';
import 'package:spotx/presentation/splash/bloc/splash_event.dart';
import 'package:spotx/presentation/splash/bloc/splash_state.dart';
import 'package:spotx/utils/force_update.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/utils.dart';
import 'package:package_info/package_info.dart';

class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  SplashBloc({required this.authRepository}) : super(const SplashState()) {
    on<CheckForceUpdate>(_checkForceUpdate);
  }
  final IAuthRepository authRepository;

  FutureOr<void> _checkForceUpdate(CheckForceUpdate event, Emitter<SplashState> emit) async {
    // ApiResponse apiResponse = await authRepository.checkForForceUpdates();
    // await handleResponse(
    //     result: apiResponse,
    //     onSuccess: () async {
    //       List<ForceUpdateEntity> forceUpdates = apiResponse.data.data;
    //       bool appNeedsUpdate = await checkForceUpdates(forceUpdates);
    //       if (appNeedsUpdate) {
    //         emit(const ForceUpdate());
    //       } else {
    //         handleNavigation();
    //       }
    //     },
    //     onFailed: () {
    //       // if for any reason check for updates failed do not block users
    //       handleNavigation();
    //     });
    handleNavigation();
  }

  Future<bool> checkForceUpdates(List<ForceUpdateEntity> forceUpdates) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    debugPrint("packageInfo - build number: ${packageInfo.buildNumber}");
    if (Platform.isAndroid) {
      // todo to be implemented after analytics integration
      /*analytics.setUserProperty(name: "build_number", value: "${packageInfo.buildNumber}");
      analytics.setUserProperty(name: "build_version", value: "${packageInfo.version}");
      analytics.logEvent(name: "android_app_version", parameters: {
        "build_number":packageInfo.buildNumber,
        "build_version":packageInfo.version
      });*/
      ForceUpdateEntity androidForceUpdateInfo =
          forceUpdates.firstWhere((element) => element.key == driverAndroidForceUpdateVersion);
      if (await isHuaweiDevice()) {
        androidForceUpdateInfo = forceUpdates.firstWhere((element) => element.key == driverHuaweiForceUpdateVersion);
      }
      debugPrint("androidForceUpdateInfo - build number: ${androidForceUpdateInfo.value}");
      if (int.parse(packageInfo.buildNumber) < int.parse(androidForceUpdateInfo.value ?? '0')) {
        return true;
      } else {
        return false;
      }
    } else if (Platform.isIOS) {
      ForceUpdateEntity iosForceUpdateInfo =
          forceUpdates.firstWhere((element) => element.key == driverIosForceUpdateVersion);
      debugPrint("androidForceUpdateInfo - build number: ${iosForceUpdateInfo.value}");
      if (int.parse(packageInfo.buildNumber) < int.parse(iosForceUpdateInfo.value ?? '0')) {
        showVersionDialog();
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  void handleNavigation() async {
    authRepository.updateFirebaseToken();
    navigationKey.currentState?.pushReplacementNamed(MainScreen.tag);
  }

  @override
  void onTransition(Transition<SplashEvent, SplashState> transition) {
    super.onTransition(transition);
    debugPrint("$transition");
  }
}