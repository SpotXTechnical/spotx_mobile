import 'package:spotx/generated/json/unit_filter_config_entity.g.dart';

import 'package:spotx/generated/json/base/json_field.dart';

@JsonSerializable()
class UnitFilterConfigEntity {
  UnitFilterConfigEntity();

  factory UnitFilterConfigEntity.fromJson(Map<String, dynamic> json) => $UnitFilterConfigEntityFromJson(json);

  Map<String, dynamic> toJson() => $UnitFilterConfigEntityToJson(this);

  @JSONField(name: "max_price")
  int? maxPrice;
  @JSONField(name: "min_price")
  int? minPrice;
  @JSONField(name: "max_rooms")
  int? maxRooms;
  @JSONField(name: "max_beds")
  int? maxBeds;
  List<UnitFilterConfigTypes>? types;
}

@JsonSerializable()
class UnitFilterConfigTypes {
  UnitFilterConfigTypes();

  factory UnitFilterConfigTypes.fromJson(Map<String, dynamic> json) => $UnitFilterConfigTypesFromJson(json);

  Map<String, dynamic> toJson() => $UnitFilterConfigTypesToJson(this);

  String? value;
  String? name;
}
