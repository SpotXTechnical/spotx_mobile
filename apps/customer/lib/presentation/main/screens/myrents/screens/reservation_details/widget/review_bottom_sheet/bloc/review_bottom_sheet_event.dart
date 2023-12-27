import 'package:equatable/equatable.dart';

abstract class ReviewBottomSheetEvent extends Equatable {}

class ReviewBottomSheetPostRating extends ReviewBottomSheetEvent {
  final String reservationId;
  final Function afterRatingAction;

  ReviewBottomSheetPostRating(this.reservationId, this.afterRatingAction);

  @override
  List<Object?> get props => [reservationId, afterRatingAction];
}

class HideError extends ReviewBottomSheetEvent {
  HideError();
  @override
  List<Object?> get props => [];
}
