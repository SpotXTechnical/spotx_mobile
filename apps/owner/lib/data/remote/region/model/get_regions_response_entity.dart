import 'dart:convert';

import 'package:owner/generated/json/get_regions_response_entity.g.dart';

import 'package:owner/generated/json/base/json_field.dart';

const int withSubRegion = 1;
const int withoutSubRegion = 0;

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
  String? description;
  @JSONField(name: "sub_regions")
  List<Region>? subRegions;

  Region({this.id, this.name, this.description, this.subRegions});

  Region clone() {
    final String jsonString = json.encode(this);
    final jsonResponse = json.decode(jsonString);
    return Region.fromJson(jsonResponse as Map<String, dynamic>);
  }
}
