import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:owner/base/base_service.dart';
import 'package:owner/data/remote/add_unit/model/image_entity.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/base_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';
import 'package:owner/utils/utils.dart';
import 'package:path/path.dart';
import 'package:video_compress/video_compress.dart';

import '../model/MediaFile.dart';

class PostMediaService extends BaseService {
  Future<ApiResponse> postMedia(MediaFile file) async {
    String compressedPath = await compressFile(file);
    Map<String, dynamic> formData = {
      "type": file.fileType,
      "media": await MultipartFile.fromFile(
        compressedPath,
        filename: basename(compressedPath),
      ),
    };

    final FormData data = FormData.fromMap(formData);
    NetworkRequest request = NetworkRequest(mediaApi, RequestMethod.post, headers: await getHeaders(), data: data);
    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {
      result.data = BaseResponse.fromJson(result.data, (json) => ImageEntity.fromJson(json));
    }
    return result;
  }

  Future<String> compressFile(MediaFile file) async {
    String path;
    if (file.fileType == videoType) {
      MediaInfo? mediaInfo = await VideoCompress.compressVideo(
        file.path!,
        quality: VideoQuality.LowQuality,
        deleteOrigin: false, // It's false by default
      );
      debugPrint("file size before: ${File(file.path!).lengthSync()}");
      debugPrint("file size after : ${mediaInfo?.file!.lengthSync()}");
      path = mediaInfo!.path!;
    } else {
      var compressedImageFile = await compressAndGetFile(File(file.path!));
      path = compressedImageFile.path;
    }
    return path;
  }
}