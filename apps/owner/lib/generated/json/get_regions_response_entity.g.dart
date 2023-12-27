import 'package:owner/generated/json/base/json_convert_content.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';

GetRegionsResponseEntity $GetRegionsResponseEntityFromJson(
    Map<String, dynamic> json) {
  final GetRegionsResponseEntity getRegionsResponseEntity = GetRegionsResponseEntity();
  final List<Region>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<Region>(e) as Region).toList();
  if (data != null) {
    getRegionsResponseEntity.data = data;
  }
  return getRegionsResponseEntity;
}

Map<String, dynamic> $GetRegionsResponseEntityToJson(
    GetRegionsResponseEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension GetRegionsResponseEntityExt on GetRegionsResponseEntity {
  GetRegionsResponseEntity copyWith({
    List<Region>? data,
  }) {
    return GetRegionsResponseEntity()
      ..data = data ?? this.data;
  }
}

Region $RegionFromJson(Map<String, dynamic> json) {
  final Region region = Region();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    region.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    region.name = name;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    region.description = description;
  }
  final List<Region>? subRegions = (json['sub_regions'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<Region>(e) as Region).toList();
  if (subRegions != null) {
    region.subRegions = subRegions;
  }
  return region;
}

Map<String, dynamic> $RegionToJson(Region entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['description'] = entity.description;
  data['sub_regions'] = entity.subRegions?.map((v) => v.toJson()).toList();
  return data;
}

extension RegionExt on Region {
  Region copyWith({
    int? id,
    String? name,
    String? description,
    List<Region>? subRegions,
  }) {
    return Region()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..description = description ?? this.description
      ..subRegions = subRegions ?? this.subRegions;
  }
}