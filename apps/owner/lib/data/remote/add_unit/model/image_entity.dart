import 'package:equatable/equatable.dart';
import 'package:owner/generated/json/image_entity.g.dart';

import 'package:owner/generated/json/base/json_field.dart';

@JsonSerializable()
class ImageEntity extends Equatable {
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

  ImageEntity({this.id, this.unitId, this.model, this.path, this.type, this.createdAt, this.updatedAt, this.url, this.thumbnail});

  static List<ImageEntity> createNewListOfImages(List<ImageEntity>? oldList) {
    List<ImageEntity>? newList = List.empty(growable: true);
    oldList?.forEach((element) {
      ImageEntity newElement = ImageEntity(
          id: element.id,
          unitId: element.unitId,
          model: element.model,
          path: element.path,
          type: element.type,
          createdAt: element.createdAt,
          updatedAt: element.updatedAt,
          url: element.url,
          thumbnail: element.thumbnail
      );
      newList.add(newElement);
    });
    return newList;
  }

  static List<int> compareImages(List<int>? actualList, List<int>? referenceList) {
    List<int>? newList = List.empty(growable: true);
    actualList?.forEach((element) {
      if (referenceList != null && !referenceList.contains(element)) {
        newList.add(element);
      }
    });
    return newList;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, unitId, model, path, type, createdAt, updatedAt, url, thumbnail];
}
