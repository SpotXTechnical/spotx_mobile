import 'package:owner/generated/json/base/json_convert_content.dart';
import 'package:owner/data/remote/statistics/model/income_entity.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';


IncomeEntity $IncomeEntityFromJson(Map<String, dynamic> json) {
  final IncomeEntity incomeEntity = IncomeEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    incomeEntity.id = id;
  }
  final String? from = jsonConvert.convert<String>(json['from']);
  if (from != null) {
    incomeEntity.from = from;
  }
  final String? to = jsonConvert.convert<String>(json['to']);
  if (to != null) {
    incomeEntity.to = to;
  }
  final int? totalPrice = jsonConvert.convert<int>(json['total_price']);
  if (totalPrice != null) {
    incomeEntity.totalPrice = totalPrice;
  }
  final Unit? unit = jsonConvert.convert<Unit>(json['unit']);
  if (unit != null) {
    incomeEntity.unit = unit;
  }
  return incomeEntity;
}

Map<String, dynamic> $IncomeEntityToJson(IncomeEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['from'] = entity.from;
  data['to'] = entity.to;
  data['total_price'] = entity.totalPrice;
  data['unit'] = entity.unit?.toJson();
  return data;
}

extension IncomeEntityExt on IncomeEntity {
  IncomeEntity copyWith({
    int? id,
    String? from,
    String? to,
    int? totalPrice,
    Unit? unit,
  }) {
    return IncomeEntity()
      ..id = id ?? this.id
      ..from = from ?? this.from
      ..to = to ?? this.to
      ..totalPrice = totalPrice ?? this.totalPrice
      ..unit = unit ?? this.unit;
  }
}