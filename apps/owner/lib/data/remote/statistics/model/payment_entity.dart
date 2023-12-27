import 'package:owner/generated/json/payment_entity.g.dart';

import 'package:owner/generated/json/base/json_field.dart';

@JsonSerializable()
class PaymentEntity {
  PaymentEntity();

  factory PaymentEntity.fromJson(Map<String, dynamic> json) => $PaymentEntityFromJson(json);

  Map<String, dynamic> toJson() => $PaymentEntityToJson(this);

  int? id;
  @JSONField(name: "unit_id")
  int? unitId;
  DateTime? date;
  int? amount;
  String? description;
  @JSONField(name: "created_at")
  String? createdAt;
  @JSONField(name: "updated_at")
  String? updatedAt;
}
