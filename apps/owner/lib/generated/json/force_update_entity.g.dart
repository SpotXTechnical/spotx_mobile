import 'package:owner/generated/json/base/json_convert_content.dart';
import 'package:owner/data/remote/auth/models/force_update_entity.dart';

ForceUpdateEntity $ForceUpdateEntityFromJson(Map<String, dynamic> json) {
  final ForceUpdateEntity forceUpdateEntity = ForceUpdateEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    forceUpdateEntity.id = id;
  }
  final String? key = jsonConvert.convert<String>(json['key']);
  if (key != null) {
    forceUpdateEntity.key = key;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    forceUpdateEntity.value = value;
  }
  final String? group = jsonConvert.convert<String>(json['group']);
  if (group != null) {
    forceUpdateEntity.group = group;
  }
  return forceUpdateEntity;
}

Map<String, dynamic> $ForceUpdateEntityToJson(ForceUpdateEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['key'] = entity.key;
  data['value'] = entity.value;
  data['group'] = entity.group;
  return data;
}

extension ForceUpdateEntityExt on ForceUpdateEntity {
  ForceUpdateEntity copyWith({
    int? id,
    String? key,
    String? value,
    String? group,
  }) {
    return ForceUpdateEntity()
      ..id = id ?? this.id
      ..key = key ?? this.key
      ..value = value ?? this.value
      ..group = group ?? this.group;
  }
}