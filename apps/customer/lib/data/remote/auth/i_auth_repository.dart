import 'dart:io';

import 'package:spotx/data/remote/auth/models/login_response_entity.dart';
import 'package:spotx/utils/network/api_response.dart';

abstract class IAuthRepository {
  Future<ApiResponse> checkForForceUpdates();
  Future<ApiResponse> checkSubDomainVerification(String subDomain);
  Future<ApiResponse> login(String phone, String password);
  Future<ApiResponse> register(String name, String email, String phone, int cityId, String password);
  Future<ApiResponse> getCities();
  Future<ApiResponse> getProfile();
  Future<ApiResponse> deleteAccount();
  Future<ApiResponse> applyCompanyCodeService(String companyCode);
  void updateFirebaseToken();
  void saveSubDomain(String subDomain);
  String getSavedSubDomain();
  void saveCredentials(LoginResponseEntity loginResponseEntity);
  Future<ApiResponse> forgotPassword(String email);
  updateLocale({required String locale});
  logOutUser();
  Future<ApiResponse> updateProfile(String name, String email, String phoneNumber, String cityId, File? imageFile);
}