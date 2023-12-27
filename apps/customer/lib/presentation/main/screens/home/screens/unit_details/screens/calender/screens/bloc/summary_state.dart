import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/reservation/model/reservation_summary_entity.dart';

class SummaryState extends Equatable {
  const SummaryState({
    this.isLoading = false,
    this.summaryLoading = false,
    this.reservationSummary,
  });

  final bool isLoading;
  final ReservationSummaryEntity? reservationSummary;
  final bool summaryLoading ;
  @override
  List<Object?> get props => [isLoading, reservationSummary, summaryLoading];

  SummaryState copyWith({
    bool? isLoading,
    bool? summaryLoading,
    ReservationSummaryEntity? reservationSummary,
  }) {
    return SummaryState(
      isLoading: isLoading ?? this.isLoading,
      summaryLoading: summaryLoading ?? this.summaryLoading,
      reservationSummary: reservationSummary ?? this.reservationSummary,
    );
  }
}