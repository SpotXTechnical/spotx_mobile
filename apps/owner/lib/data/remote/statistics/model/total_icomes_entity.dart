import 'package:owner/generated/json/total_icomes_entity.g.dart';

import 'package:owner/generated/json/base/json_field.dart';

@JsonSerializable()
class TotalIncomesEntity {
  TotalIncomesEntity();

  factory TotalIncomesEntity.fromJson(Map<String, dynamic> json) => $TotalIncomesEntityFromJson(json);

  Map<String, dynamic> toJson() => $TotalIncomesEntityToJson(this);

  @JSONField(name: "reservation_count")
  int? reservationCount;
  @JSONField(name: "total_income")
  int? totalIncomes;
  @JSONField(name: "total_payments")
  int? totalPayments;
  double? revenue;
}
