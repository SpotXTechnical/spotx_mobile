import 'package:equatable/equatable.dart';

class ReviewBottomSheetState extends Equatable {
  const ReviewBottomSheetState({this.isLoading = false, this.ownerRate = "5", this.unitRate = "5"});

  final bool isLoading;
  final String ownerRate;
  final String unitRate;

  @override
  List<Object?> get props => [isLoading, ownerRate, unitRate];

  ReviewBottomSheetState copyWith({bool? isLoading, String? ownerRate, String? unitRate}) {
    return ReviewBottomSheetState(
        isLoading: isLoading ?? this.isLoading,
        ownerRate: ownerRate ?? this.ownerRate,
        unitRate: unitRate ?? this.unitRate);
  }
}
