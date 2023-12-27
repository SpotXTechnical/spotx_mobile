import 'package:spotx/generated/json/review_entity.g.dart';

import 'package:spotx/data/remote/auth/models/login_response_entity.dart';
import 'package:spotx/generated/json/base/json_field.dart';

@JsonSerializable()
class ReviewEntity {
  ReviewEntity();

  factory ReviewEntity.fromJson(Map<String, dynamic> json) => $ReviewEntityFromJson(json);

  Map<String, dynamic> toJson() => $ReviewEntityToJson(this);

  int? id;
  @JSONField(name: "reservation_id")
  int? reservationId;
  @JSONField(name: "unit_id")
  int? unitId;
  @JSONField(name: "user_id")
  int? userId;
  String? message;
  @JSONField(name: "unit_rate")
  int? unitRate;
  @JSONField(name: "owner_rate")
  int? ownerRate;
  @JSONField(name: "created_at")
  DateTime? createdAt;
  @JSONField(name: "updated_at")
  DateTime? updatedAt;
  User? user;
}
