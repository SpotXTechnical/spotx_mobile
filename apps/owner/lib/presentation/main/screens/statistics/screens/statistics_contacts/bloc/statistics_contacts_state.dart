import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/statistics/model/total_icomes_entity.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_contacts/utils.dart';

class StatisticsContactsState extends Equatable {
  const StatisticsContactsState(
      {this.selectedUserType = SelectedUsersType.user,
      this.isLoading = false,
      this.entities,
      this.isDetailsHeaderLoading = false,
      this.hasMore = false,
      this.totalIncomesEntity});
  final SelectedUsersType selectedUserType;
  final bool isLoading;
  final bool hasMore;
  final bool isDetailsHeaderLoading;
  final List<Object>? entities;
  final TotalIncomesEntity? totalIncomesEntity;

  @override
  List<Object?> get props =>
      [selectedUserType, isLoading, hasMore, entities, isDetailsHeaderLoading, totalIncomesEntity];

  StatisticsContactsState copyWith(
      {SelectedUsersType? selectedUserType,
      bool? isLoading,
      bool? hasMore,
      List<Object>? entities,
      bool? isDetailsHeaderLoading,
      TotalIncomesEntity? totalIncomesEntity}) {
    return StatisticsContactsState(
        selectedUserType: selectedUserType ?? this.selectedUserType,
        isLoading: isLoading ?? this.isLoading,
        hasMore: hasMore ?? this.hasMore,
        entities: entities ?? this.entities,
        isDetailsHeaderLoading: isDetailsHeaderLoading ?? this.isDetailsHeaderLoading,
        totalIncomesEntity: totalIncomesEntity ?? this.totalIncomesEntity);
  }
}
