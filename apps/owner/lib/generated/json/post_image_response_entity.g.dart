import 'package:owner/generated/json/base/json_convert_content.dart';
import 'package:owner/data/remote/add_unit/model/post_image_response_entity.dart';

PostImageResponseEntity $PostImageResponseEntityFromJson(
    Map<String, dynamic> json) {
  final PostImageResponseEntity postImageResponseEntity = PostImageResponseEntity();
  final int? mediaId = jsonConvert.convert<int>(json['media_id']);
  if (mediaId != null) {
    postImageResponseEntity.mediaId = mediaId;
  }
  return postImageResponseEntity;
}

Map<String, dynamic> $PostImageResponseEntityToJson(
    PostImageResponseEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['media_id'] = entity.mediaId;
  return data;
}

extension PostImageResponseEntityExt on PostImageResponseEntity {
  PostImageResponseEntity copyWith({
    int? mediaId,
  }) {
    return PostImageResponseEntity()
      ..mediaId = mediaId ?? this.mediaId;
  }
}