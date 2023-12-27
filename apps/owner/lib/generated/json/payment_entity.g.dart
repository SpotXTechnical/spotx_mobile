import 'package:owner/generated/json/base/json_convert_content.dart';
import 'package:owner/data/remote/statistics/model/payment_entity.dart';

PaymentEntity $PaymentEntityFromJson(Map<String, dynamic> json) {
  final PaymentEntity paymentEntity = PaymentEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    paymentEntity.id = id;
  }
  final int? unitId = jsonConvert.convert<int>(json['unit_id']);
  if (unitId != null) {
    paymentEntity.unitId = unitId;
  }
  final DateTime? date = jsonConvert.convert<DateTime>(json['date']);
  if (date != null) {
    paymentEntity.date = date;
  }
  final int? amount = jsonConvert.convert<int>(json['amount']);
  if (amount != null) {
    paymentEntity.amount = amount;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    paymentEntity.description = description;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    paymentEntity.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    paymentEntity.updatedAt = updatedAt;
  }
  return paymentEntity;
}

Map<String, dynamic> $PaymentEntityToJson(PaymentEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['unit_id'] = entity.unitId;
  data['date'] = entity.date?.toIso8601String();
  data['amount'] = entity.amount;
  data['description'] = entity.description;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  return data;
}

extension PaymentEntityExt on PaymentEntity {
  PaymentEntity copyWith({
    int? id,
    int? unitId,
    DateTime? date,
    int? amount,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) {
    return PaymentEntity()
      ..id = id ?? this.id
      ..unitId = unitId ?? this.unitId
      ..date = date ?? this.date
      ..amount = amount ?? this.amount
      ..description = description ?? this.description
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt;
  }
}