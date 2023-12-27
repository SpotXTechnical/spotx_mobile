import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/statistics/model/statistics_filter.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_details/utils.dart';

abstract class StatisticsDetailsEvent extends Equatable {
  const StatisticsDetailsEvent();
}

class SetSelectionFinancialTypeEvent extends StatisticsDetailsEvent {
  final SelectedFinancialType selectedFinancialType;
  const SetSelectionFinancialTypeEvent(this.selectedFinancialType);

  @override
  List<Object?> get props => [selectedFinancialType];
}

class GetPaymentsEvent extends StatisticsDetailsEvent {
  const GetPaymentsEvent();

  @override
  List<Object?> get props => [];
}

class LoadMorePaymentsEvent extends StatisticsDetailsEvent {
  const LoadMorePaymentsEvent();

  @override
  List<Object?> get props => [];
}

class GetIncomesEvent extends StatisticsDetailsEvent {
  const GetIncomesEvent();

  @override
  List<Object?> get props => [];
}

class LoadMoreIncomesEvent extends StatisticsDetailsEvent {
  const LoadMoreIncomesEvent();

  @override
  List<Object?> get props => [];
}

class GetTotalIncomesEvent extends StatisticsDetailsEvent {
  const GetTotalIncomesEvent();

  @override
  List<Object?> get props => [];
}

class DeletePaymentEvent extends StatisticsDetailsEvent {
  final String paymentId;
  const DeletePaymentEvent(this.paymentId);

  @override
  List<Object?> get props => [paymentId];
}

class GetStatisticsData extends StatisticsDetailsEvent {
  final StatisticsFilter statisticsFilter;
  const GetStatisticsData(this.statisticsFilter);

  @override
  List<Object?> get props => [statisticsFilter];
}