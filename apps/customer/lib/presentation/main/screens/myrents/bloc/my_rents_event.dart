import 'package:equatable/equatable.dart';
import 'package:spotx/presentation/main/screens/myrents/bloc/my_rents_state.dart';

abstract class MyRentsEvent extends Equatable {}

class GetReservations extends MyRentsEvent {
  GetReservations();

  @override
  List<Object?> get props => [];
}

class GetUpcomingReservations extends MyRentsEvent {
  GetUpcomingReservations();

  @override
  List<Object?> get props => [];
}

class GetPastReservations extends MyRentsEvent {
  GetPastReservations();

  @override
  List<Object?> get props => [];
}

class SetSelectedRentType extends MyRentsEvent {
  final SelectedRentType selectedRentType;
  SetSelectedRentType(this.selectedRentType);
  @override
  List<Object?> get props => [selectedRentType];
}

class LoadMoreUpComingReservations extends MyRentsEvent {
  LoadMoreUpComingReservations();
  @override
  List<Object?> get props => [];
}

class LoadMorePastReservations extends MyRentsEvent {
  LoadMorePastReservations();
  @override
  List<Object?> get props => [];
}

class MyRentCheckIfUserIsLoggedInEvent extends MyRentsEvent {
  MyRentCheckIfUserIsLoggedInEvent();

  @override
  List<Object?> get props => [];
}