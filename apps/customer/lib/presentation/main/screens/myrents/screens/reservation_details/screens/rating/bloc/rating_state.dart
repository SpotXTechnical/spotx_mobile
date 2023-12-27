import 'package:equatable/equatable.dart';

class RatingState extends Equatable {
  const RatingState({this.isLoading = false, this.ownerRate = "5", this.unitRate = "5"});
  final bool isLoading;
  final String ownerRate;
  final String unitRate;

  @override
  List<Object?> get props => [isLoading, ownerRate, unitRate];

  RatingState copyWith({bool? isLoading, String? ownerRate, String? unitRate}) {
    return RatingState(
        isLoading: isLoading ?? this.isLoading,
        ownerRate: ownerRate ?? this.ownerRate,
        unitRate: unitRate ?? this.unitRate);
  }
}
