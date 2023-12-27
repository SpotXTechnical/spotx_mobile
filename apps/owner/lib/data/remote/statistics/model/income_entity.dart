import 'package:owner/generated/json/income_entity.g.dart';

import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/generated/json/base/json_field.dart';

@JsonSerializable()
class IncomeEntity {
  IncomeEntity();

  factory IncomeEntity.fromJson(Map<String, dynamic> json) => $IncomeEntityFromJson(json);

  Map<String, dynamic> toJson() => $IncomeEntityToJson(this);

  int? id;
  String? from;
  String? to;
  @JSONField(name: "total_price")
  int? totalPrice;
  Unit? unit;
}
