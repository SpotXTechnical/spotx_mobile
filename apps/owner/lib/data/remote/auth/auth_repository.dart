import 'dart:io';

import 'package:owner/data/local/shared_prefs_manager.dart';
import 'package:owner/data/remote/auth/i_auth_repository.dart';
import 'package:owner/data/remote/auth/models/login_response_entity.dart';
import 'package:owner/data/remote/auth/services/delete_account_service.dart';
import 'package:owner/data/remote/auth/services/login_service.dart';
import 'package:owner/data/remote/auth/services/logout_service.dart';
import 'package:owner/data/remote/auth/services/register_service.dart';
import 'package:owner/data/remote/auth/services/update_firebase_token_service.dart';
import 'package:owner/data/remote/auth/services/user_service.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class AuthRepository implements IAuthRepository {
  final LoginService _loginService = LoginService();
  final RegisterService _registerService = RegisterService();
  final GetUserService _getUserService = GetUserService();
  final UpdateFireBaseTokenService _updateFireBaseTokenService = UpdateFireBaseTokenService();
  final LogoutService _logoutService = LogoutService();
  final DeleteAccountService _deleteAccountService = DeleteAccountService();

  @override
  Future<ApiResponse> login(String userName, String password) {
    return _loginService.login(userName, password);
  }

  @override
  void saveCredentials(LoginResponseEntity loginResponseEntity) {
    final SharedPrefsManager sharedPrefsManager = Injector().get<SharedPrefsManager>();
    sharedPrefsManager.credentials = loginResponseEntity;
  }

  @override
  Future<ApiResponse> register(String name, String email, String phone, String password, String userType,
      File imageFile, String nationalId, File nationalIdImage, String whatsAppNumber) {
    return _registerService.register(
        name, email, phone, password, userType, imageFile, nationalId, nationalIdImage, whatsAppNumber);
  }

  @override
  Future<ApiResponse> getUser() {
    return _getUserService.getUser();
  }

  @override
  void updateFirebaseToken() async {
    // use fire base FCM in case of ios or android with google play service
    _updateFireBaseTokenService.updateFirebaseToken();
  }

  @override
  void logOutUser() {
    _logoutService.logout();
  }

  @override
  Future<ApiResponse> deleteAccount() {
    return _deleteAccountService.deleteAccount();
  }
}
