import 'dart:io';

import 'package:dio/dio.dart';
import 'package:spotx/base/base_service.dart';
import 'package:spotx/data/remote/auth/models/login_response_entity.dart';
import 'package:spotx/utils/media_utils/utils.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/network/base_response.dart';
import 'package:spotx/utils/network/const.dart';
import 'package:spotx/utils/network/network_request.dart';
import 'package:path/path.dart';

class UpdateProfileService extends BaseService {
  Future<ApiResponse> updateProfile(
      String name, String email, String phoneNumber, String cityId, File? imageFile) async {
    File? compressedImageFile;
    if (imageFile != null) {
      compressedImageFile = await compressAndGetFile(imageFile);
    }

    Map<String, dynamic> formData = {
      "email": email,
      "phone": phoneNumber,
      "city_id": cityId,
      "name": name,
    };
    if (imageFile != null) {
      formData["image"] = await MultipartFile.fromFile(
        compressedImageFile!.path,
        filename: basename(compressedImageFile.path),
      );
    }
    final FormData data = FormData.fromMap(formData);
    NetworkRequest request = NetworkRequest(getProfileApi, RequestMethod.post, headers: await getHeaders(), data: data);
    var result = await networkManager.perform(request);
    if (result.status == Status.OK) {
      result.data = BaseResponse.fromJson(result.data, (json) => User.fromJson(json));
    }
    return result;
  }
}
