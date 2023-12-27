import 'package:spotx/generated/json/base/json_field.dart';
import 'package:spotx/generated/json/force_update_entity.g.dart';

@JsonSerializable()
class ForceUpdateEntity {
  ForceUpdateEntity();

  factory ForceUpdateEntity.fromJson(Map<String, dynamic> json) => $ForceUpdateEntityFromJson(json);

  Map<String, dynamic> toJson() => $ForceUpdateEntityToJson(this);

  int? id;
  String? key;
  String? value;
  String? group;
}
