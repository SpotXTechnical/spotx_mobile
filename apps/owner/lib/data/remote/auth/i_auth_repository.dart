import 'dart:io';

import 'package:owner/data/remote/auth/models/login_response_entity.dart';
import 'package:owner/utils/network/api_response.dart';

abstract class IAuthRepository {
  Future<ApiResponse> login(String userName, String password);
  void saveCredentials(LoginResponseEntity loginResponseEntity);
  Future<ApiResponse> register(String name, String email, String phone, String password, String userType,
      File imageFile, String nationalId, File nationalIdImage, String whatsAppNumber);
  Future<ApiResponse> getUser();
  Future<ApiResponse> deleteAccount();
  void updateFirebaseToken();
  void logOutUser();
}
