import 'dart:io';
import 'package:spotx/data/local/shared_prefs_manager.dart';
import 'package:spotx/data/remote/auth/i_auth_repository.dart';
import 'package:spotx/data/remote/auth/models/login_response_entity.dart';
import 'package:spotx/data/remote/auth/services/company_code_service.dart';
import 'package:spotx/data/remote/auth/services/delete_account_service.dart';
import 'package:spotx/data/remote/auth/services/force_update_service.dart';
import 'package:spotx/data/remote/auth/services/forget_password_service.dart';
import 'package:spotx/data/remote/auth/services/get_Profile_service.dart';
import 'package:spotx/data/remote/auth/services/get_cities_service.dart';
import 'package:spotx/data/remote/auth/services/login_service.dart';
import 'package:spotx/data/remote/auth/services/logout_service.dart';
import 'package:spotx/data/remote/auth/services/register_service.dart';
import 'package:spotx/data/remote/auth/services/subdomain_verification_service.dart';
import 'package:spotx/data/remote/auth/services/update_Profile_service.dart';
import 'package:spotx/data/remote/auth/services/update_firebase_token_service.dart';
import 'package:spotx/data/remote/auth/services/update_locale_service.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class AuthRepository implements IAuthRepository {
  final ForceUpdateService _forceUpdateService = ForceUpdateService();
  final SubDomainVerificationService _subDomainVerificationService = SubDomainVerificationService();
  final LoginService _loginService = LoginService();
  final RegisterService _registerService = RegisterService();
  final GetCitiesService _getCities = GetCitiesService();
  final ForgetPasswordService _forgetPasswordService = ForgetPasswordService();
  final UpdateFireBaseTokenService _updateFireBaseTokenService = UpdateFireBaseTokenService();
  final UpdateLocaleService _updateLocaleService = UpdateLocaleService();
  final LogoutService _logoutService = LogoutService();
  final GetProfileService _getProfile = GetProfileService();
  final UpdateProfileService _updateProfileService = UpdateProfileService();
  final DeleteAccountService _deleteAccountService = DeleteAccountService();
  final _companyService = CompanyCodeService();

  @override
  Future<ApiResponse> checkForForceUpdates() {
    return _forceUpdateService.checkForForceUpdates();
  }

  @override
  Future<ApiResponse> checkSubDomainVerification(String subDomain) {
    return _subDomainVerificationService.checkSubDomainVerification(subDomain);
  }

  @override
  Future<ApiResponse> login(String phone, String password) {
    return _loginService.login(phone, password);
  }

  @override
  void updateFirebaseToken() async {
    // use fire base FCM in case of ios or android with google play service
    _updateFireBaseTokenService.updateFirebaseToken();
  }

  @override
  void saveSubDomain(String subDomain) {
    final SharedPrefsManager sharedPrefsManager = Injector().get<SharedPrefsManager>();
    sharedPrefsManager.subDomain = subDomain;
  }

  @override
  void saveCredentials(LoginResponseEntity loginResponseEntity) {
    final SharedPrefsManager sharedPrefsManager = Injector().get<SharedPrefsManager>();
    sharedPrefsManager.credentials = loginResponseEntity;
  }

  @override
  Future<ApiResponse> forgotPassword(String email) {
    return _forgetPasswordService.forgotPassword(email);
  }

  @override
  updateLocale({required String locale}) {
    _updateLocaleService.updateLocale(locale: locale);
  }

  @override
  logOutUser() {
    return _logoutService.logout();
  }

  @override
  String getSavedSubDomain() {
    final SharedPrefsManager sharedPrefsManager = Injector().get<SharedPrefsManager>();
    return sharedPrefsManager.subDomain;
  }

  @override
  Future<ApiResponse> register(String name, String email, String phone, int cityId, String password) {
    return _registerService.register(name, email, phone, cityId, password);
  }

  @override
  Future<ApiResponse> getCities() {
    return _getCities.getCities();
  }

  @override
  Future<ApiResponse> getProfile() {
    return _getProfile.getProfile();
  }

  @override
  Future<ApiResponse> updateProfile(String name, String email, String phoneNumber, String cityId, File? imageFile) {
    return _updateProfileService.updateProfile(name, email, phoneNumber, cityId, imageFile);
  }

  @override
  Future<ApiResponse> deleteAccount() {
    return _deleteAccountService.deleteAccount();
  }

  @override
  Future<ApiResponse> applyCompanyCodeService(String companyCode) {
    return _companyService.applyCompanyService(companyCode);
  }
}