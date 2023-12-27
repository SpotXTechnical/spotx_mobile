import 'package:equatable/equatable.dart';

abstract class SummaryEvent extends Equatable {}

class PostReservation extends SummaryEvent {
  final String from;
  final String to;
  final int unitId;
  final String unitType;
  PostReservation(
    this.from,
    this.to,
    this.unitId,
    this.unitType,
  );

  @override
  List<Object?> get props => [PostReservation];
}


class ReservationSummary extends SummaryEvent {
  final String from;
  final String to;
  final int unitId;
  final String unitType;
  ReservationSummary(
      this.from,
      this.to,
      this.unitId,
      this.unitType,
      );

  @override
  List<Object?> get props => [PostReservation];
}

class HideError extends SummaryEvent {
  HideError();
  @override
  List<Object?> get props => [];
}