import 'package:equatable/equatable.dart';
import 'package:owner/generated/json/review_entity.g.dart';

import 'package:owner/data/remote/auth/models/login_response_entity.dart';
import 'package:owner/generated/json/base/json_field.dart';

@JsonSerializable()
class ReviewEntity extends Equatable {
  factory ReviewEntity.fromJson(Map<String, dynamic> json) => $ReviewEntityFromJson(json);

  Map<String, dynamic> toJson() => $ReviewEntityToJson(this);

  int? id;
  @JSONField(name: "reservation_id")
  int? reservationId;

  ReviewEntity(
      {this.id,
      this.reservationId,
      this.unitId,
      this.userId,
      this.message,
      this.unitRate,
      this.ownerRate,
      this.createdAt,
      this.updatedAt,
      this.user});

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

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, reservationId, unitId, userId, message, unitRate, ownerRate, createdAt, updatedAt, user];

  static List<ReviewEntity>? createNewList(List<ReviewEntity>? oldList) {
    List<ReviewEntity>? newList = List.empty(growable: true);
    oldList?.forEach((element) {
      ReviewEntity newElement = ReviewEntity(
          id: element.id,
          reservationId: element.reservationId,
          unitId: element.unitId,
          userId: element.userId,
          message: element.message,
          unitRate: element.unitRate,
          ownerRate: element.ownerRate,
          createdAt: element.createdAt,
          updatedAt: element.updatedAt,
          user: User.createNewElement(element.user));
      newList.add(newElement);
    });
    return newList;
  }
}
