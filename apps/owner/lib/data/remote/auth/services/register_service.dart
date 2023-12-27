import 'dart:io';
import 'package:dio/dio.dart';
import 'package:owner/base/base_service.dart';
import 'package:owner/data/remote/auth/models/register_response_entity.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/base_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';
import 'package:owner/utils/utils.dart';
import 'package:path/path.dart';

class RegisterService extends BaseService {
  Future<ApiResponse> register(String name, String email, String phone, String password, String userType, File imageFile, String nationalId,
      File nationalIdImage, String whatsAppNumber) async {
    var compressedImageFile = await compressAndGetFile(imageFile);
    var compressedNationalIdImageFile = await compressAndGetFile(nationalIdImage);

    Map<String, dynamic> formData = {
      "email": email,
      "password": password,
      "phone": phone,
      "name": name,
      "type": userType,
      "image": await MultipartFile.fromFile(
        compressedImageFile.path,
        filename: basename(compressedImageFile.path),
      ),
      "whatsapp": whatsAppNumber,
      "national_id_image": await MultipartFile.fromFile(
        compressedNationalIdImageFile.path,
        filename: basename(compressedNationalIdImageFile.path),
      ),
    };

    final FormData data = FormData.fromMap(formData);

    NetworkRequest request = NetworkRequest(registerApi, RequestMethod.post, headers: await getHeaders(), data: data);

    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {
      result.data = BaseResponse.fromJson(result.data, (json) => RegisterResponseEntity.fromJson(json));
    }
    return result;
  }
}
