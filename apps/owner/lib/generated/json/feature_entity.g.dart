import 'package:owner/generated/json/base/json_convert_content.dart';
import 'package:owner/data/remote/add_unit/model/feature_entity.dart';


Feature $FeatureFromJson(Map<String, dynamic> json) {
  final Feature feature = Feature();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    feature.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    feature.name = name;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    feature.url = url;
  }
  final bool? isSelected = jsonConvert.convert<bool>(json['isSelected']);
  if (isSelected != null) {
    feature.isSelected = isSelected;
  }
  return feature;
}

Map<String, dynamic> $FeatureToJson(Feature entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['url'] = entity.url;
  data['isSelected'] = entity.isSelected;
  return data;
}

extension FeatureExt on Feature {
  Feature copyWith({
    int? id,
    String? name,
    String? url,
    bool? isSelected,
  }) {
    return Feature()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..url = url ?? this.url
      ..isSelected = isSelected ?? this.isSelected;
  }
}