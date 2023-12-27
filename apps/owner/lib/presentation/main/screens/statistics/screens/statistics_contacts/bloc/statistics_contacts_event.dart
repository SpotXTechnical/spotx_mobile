import 'package:equatable/equatable.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_contacts/utils.dart';

abstract class StatisticsContactsEvent extends Equatable {
  const StatisticsContactsEvent();
}

class SetSelectionUserTypeEvent extends StatisticsContactsEvent {
  final SelectedUsersType selectedUsersType;
  const SetSelectionUserTypeEvent(this.selectedUsersType);

  @override
  List<Object?> get props => [selectedUsersType];
}

class GetUsersEvent extends StatisticsContactsEvent {
  const GetUsersEvent();

  @override
  List<Object?> get props => [];
}

class LoadMoreUsersEvent extends StatisticsContactsEvent {
  const LoadMoreUsersEvent();

  @override
  List<Object?> get props => [];
}

class GetGuestsEvent extends StatisticsContactsEvent {
  const GetGuestsEvent();

  @override
  List<Object?> get props => [];
}

class LoadMoreGuestsEvent extends StatisticsContactsEvent {
  const LoadMoreGuestsEvent();

  @override
  List<Object?> get props => [];
}
