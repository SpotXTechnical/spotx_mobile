import 'package:spotx/generated/json/room_details_entity.g.dart';

import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/generated/json/base/json_field.dart';

@JsonSerializable()
class RoomDetailsEntity {
  RoomDetailsEntity();

  factory RoomDetailsEntity.fromJson(Map<String, dynamic> json) => $RoomDetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => $RoomDetailsEntityToJson(this);

  RoomDetailsData? data;
  dynamic? message;
}

@JsonSerializable()
class RoomDetailsData {
  RoomDetailsData();

  factory RoomDetailsData.fromJson(Map<String, dynamic> json) => $RoomDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => $RoomDetailsDataToJson(this);

  int? id;
  String? model;
  String? code;
  @JSONField(name: "default_price")
  int? defaultPrice;
  String? title;
  String? description;
  int? beds;
  int? guests;
  int? bathrooms;
  @JSONField(name: "active_reservations")
  List<ActiveReservation>? activeReservations;
  @JSONField(name: "active_ranges")
  List<ActiveRange>? activeRanges;
}
