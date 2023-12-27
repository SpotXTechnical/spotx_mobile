import 'package:equatable/equatable.dart';

abstract class RatingEvent extends Equatable {}

class PostRating extends RatingEvent {
  final String reservationId;

  PostRating(this.reservationId);

  @override
  List<Object?> get props => [reservationId];
}

class HideError extends RatingEvent {
  HideError();
  @override
  List<Object?> get props => [];
}
