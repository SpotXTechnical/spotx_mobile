import 'package:spotx/generated/json/image_entity.g.dart';
import 'package:spotx/generated/json/base/json_field.dart';

@JsonSerializable()
class ImageEntity {
  ImageEntity();

  factory ImageEntity.fromJson(Map<String, dynamic> json) => $ImageEntityFromJson(json);

  Map<String, dynamic> toJson() => $ImageEntityToJson(this);

  int? id;
  @JSONField(name: "unit_id")
  int? unitId;
  dynamic? model;
  String? path;
  String? type;
  @JSONField(name: "created_at")
  String? createdAt;
  @JSONField(name: "updated_at")
  String? updatedAt;
  String? url;
  String? thumbnail;
  @JSONField(name: "is_default")
  int? isDefault;
}

const imageType = "image";
const videoType = "video";

extension ImageListExtensions on List<ImageEntity> {
  ImageEntity? findImageToDisplay() {
    return firstWhere((image) => image.isDefault == 1, orElse: () => first);
  }
}