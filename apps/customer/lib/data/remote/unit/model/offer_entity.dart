import 'package:spotx/generated/json/offer_entity.g.dart';

import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/generated/json/base/json_field.dart';

@JsonSerializable()
class OfferEntity {
  factory OfferEntity.fromJson(Map<String, dynamic> json) => $OfferEntityFromJson(json);

  Map<String, dynamic> toJson() => $OfferEntityToJson(this);
  int? id;
  String? from;
  String? to;
  @JSONField(name: "from")
  DateTime? startDate;
  @JSONField(name: "to")
  DateTime? endDate;
  int? price;
  @JSONField(name: "created_at")
  String? createdAt;
  @JSONField(name: "unit_id")
  dynamic? unitId;
  Unit? unit;
  @JSONField(name: "total_price")
  int? totalPrice;
  @JSONField(name: "days_count")
  int? dayCount;
  OfferEntity({this.from, this.to, this.price, this.createdAt, this.unitId, this.unit, this.totalPrice, this.id});

  void addDayToEnd() => endDate = endDate?.add(const Duration(days: 1));

}