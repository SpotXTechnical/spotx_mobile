import 'package:spotx/generated/json/base/json_field.dart';
import 'package:spotx/generated/json/get_cities_response_entity.g.dart';

@JsonSerializable()
class GetCitiesResponseEntity {
  GetCitiesResponseEntity();

  factory GetCitiesResponseEntity.fromJson(Map<String, dynamic> json) => $GetCitiesResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => $GetCitiesResponseEntityToJson(this);

  List<City>? data;
}

@JsonSerializable()
class City {
  City();

  factory City.fromJson(Map<String, dynamic> json) => $CityFromJson(json);

  Map<String, dynamic> toJson() => $CityToJson(this);

  int? id;
  String? name;
}
