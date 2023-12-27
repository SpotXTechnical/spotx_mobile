import 'package:owner/generated/json/base/json_convert_content.dart';
import 'package:owner/data/remote/statistics/model/total_icomes_entity.dart';

TotalIncomesEntity $TotalIncomesEntityFromJson(Map<String, dynamic> json) {
  final TotalIncomesEntity totalIncomesEntity = TotalIncomesEntity();
  final int? reservationCount = jsonConvert.convert<int>(
      json['reservation_count']);
  if (reservationCount != null) {
    totalIncomesEntity.reservationCount = reservationCount;
  }
  final int? totalIncomes = jsonConvert.convert<int>(json['total_income']);
  if (totalIncomes != null) {
    totalIncomesEntity.totalIncomes = totalIncomes;
  }
  final int? totalPayments = jsonConvert.convert<int>(json['total_payments']);
  if (totalPayments != null) {
    totalIncomesEntity.totalPayments = totalPayments;
  }
  final double? revenue = jsonConvert.convert<double>(json['revenue']);
  if (revenue != null) {
    totalIncomesEntity.revenue = revenue;
  }
  return totalIncomesEntity;
}

Map<String, dynamic> $TotalIncomesEntityToJson(TotalIncomesEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['reservation_count'] = entity.reservationCount;
  data['total_income'] = entity.totalIncomes;
  data['total_payments'] = entity.totalPayments;
  data['revenue'] = entity.revenue;
  return data;
}

extension TotalIncomesEntityExt on TotalIncomesEntity {
  TotalIncomesEntity copyWith({
    int? reservationCount,
    int? totalIncomes,
    int? totalPayments,
    double? revenue,
  }) {
    return TotalIncomesEntity()
      ..reservationCount = reservationCount ?? this.reservationCount
      ..totalIncomes = totalIncomes ?? this.totalIncomes
      ..totalPayments = totalPayments ?? this.totalPayments
      ..revenue = revenue ?? this.revenue;
  }
}