import 'dart:convert';

import 'package:spotx/data/remote/unit/model/image_entity.dart';
import 'package:spotx/generated/json/get_regions_response_entity.g.dart';
import 'package:spotx/generated/json/base/json_field.dart';

const int withSubRegion = 1;
const int subRegionCount = 1;
const int withoutSubRegion = 0;
const int isMostPopular = 1;

@JsonSerializable()
class GetRegionsResponseEntity {
  GetRegionsResponseEntity();

  factory GetRegionsResponseEntity.fromJson(Map<String, dynamic> json) => $GetRegionsResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => $GetRegionsResponseEntityToJson(this);

  List<Region>? data;
}

@JsonSerializable()
class Region {
  factory Region.fromJson(Map<String, dynamic> json) => $RegionFromJson(json);

  Map<String, dynamic> toJson() => $RegionToJson(this);

  int? id;
  String? name;
  List<ImageEntity>? images;
  String? description;
  @JSONField(name: "sub_regions")
  List<Region>? subRegions;
  @JSONField(name: "subRegion_count")
  int? subRegionCount;
  @JSONField(name: "has_subRegions")
  bool? hasSubRegion;

  Region({this.id, this.name, this.description, this.subRegions, this.hasSubRegion});

  Region clone() {
    final String jsonString = json.encode(this);
    final jsonResponse = json.decode(jsonString);
    return Region.fromJson(jsonResponse as Map<String, dynamic>);
  }

  Map<String, dynamic> regionToJson(Region entity) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = entity.id;
    data['name'] = entity.name;
    return data;
  }
}