import 'package:equatable/equatable.dart';

abstract class StatisticsEvent extends Equatable {
  const StatisticsEvent();
}

class GetHomeCampsEvent extends StatisticsEvent {
  const GetHomeCampsEvent();

  @override
  List<Object?> get props => [];
}

class GetTotalIncomesEvent extends StatisticsEvent {
  const GetTotalIncomesEvent();

  @override
  List<Object?> get props => [];
}
