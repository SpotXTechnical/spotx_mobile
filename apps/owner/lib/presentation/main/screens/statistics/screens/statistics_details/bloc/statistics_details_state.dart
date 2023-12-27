import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/statistics/model/statistics_filter.dart';
import 'package:owner/data/remote/statistics/model/total_icomes_entity.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_details/utils.dart';

class StatisticsDetailsState extends Equatable {
  const StatisticsDetailsState(
      {this.selectedFinancialType = SelectedFinancialType.payment,
      this.isLoading = false,
      this.entities,
      this.isDetailsHeaderLoading = false,
      this.hasMore = false,
      this.totalIncomesEntity,
      this.statisticsFilter});
  final SelectedFinancialType selectedFinancialType;
  final bool isLoading;
  final bool hasMore;
  final bool isDetailsHeaderLoading;
  final List<Object>? entities;
  final TotalIncomesEntity? totalIncomesEntity;
  final StatisticsFilter? statisticsFilter;

  @override
  List<Object?> get props => [
        selectedFinancialType,
        isLoading,
        hasMore,
        entities,
        isDetailsHeaderLoading,
        totalIncomesEntity,
        statisticsFilter
      ];

  StatisticsDetailsState copyWith(
      {SelectedFinancialType? selectedFinancialType,
      bool? isLoading,
      bool? hasMore,
      List<Object>? entities,
      bool? isDetailsHeaderLoading,
      TotalIncomesEntity? totalIncomesEntity,
      StatisticsFilter? statisticsFilter}) {
    return StatisticsDetailsState(
        selectedFinancialType: selectedFinancialType ?? this.selectedFinancialType,
        isLoading: isLoading ?? this.isLoading,
        hasMore: hasMore ?? this.hasMore,
        entities: entities ?? this.entities,
        isDetailsHeaderLoading: isDetailsHeaderLoading ?? this.isDetailsHeaderLoading,
        totalIncomesEntity: totalIncomesEntity ?? this.totalIncomesEntity,
        statisticsFilter: statisticsFilter ?? this.statisticsFilter);
  }
}
