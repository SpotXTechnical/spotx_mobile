import 'package:owner/generated/json/post_image_response_entity.g.dart';

import 'package:owner/generated/json/base/json_field.dart';

@JsonSerializable()
class PostImageResponseEntity {
  PostImageResponseEntity();

  factory PostImageResponseEntity.fromJson(Map<String, dynamic> json) => $PostImageResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => $PostImageResponseEntityToJson(this);

  @JSONField(name: "media_id")
  int? mediaId;
}
