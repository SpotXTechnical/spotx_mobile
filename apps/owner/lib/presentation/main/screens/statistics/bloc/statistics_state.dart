import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';
import 'package:owner/data/remote/statistics/model/total_icomes_entity.dart';

class StatisticsState extends Equatable {
  const StatisticsState({this.isDetailsHeaderLoading = false, this.totalIncomesEntity});

  final TotalIncomesEntity? totalIncomesEntity;
  final bool isDetailsHeaderLoading;

  @override
  List<Object?> get props => [totalIncomesEntity, isDetailsHeaderLoading];

  StatisticsState copyWith({TotalIncomesEntity? totalIncomesEntity, bool? isDetailsHeaderLoading}) {
    return StatisticsState(
        totalIncomesEntity: totalIncomesEntity ?? this.totalIncomesEntity,
        isDetailsHeaderLoading: isDetailsHeaderLoading ?? this.isDetailsHeaderLoading);
  }
}
