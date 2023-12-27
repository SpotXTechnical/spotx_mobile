import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/unit/model/offer_entity.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';

class UnitDetailsState extends Equatable {
  const UnitDetailsState(
      {this.isLoading = false,
      this.unit,
      this.isError = false,
      this.selectedContentType = SelectedContentType.overView,
      this.offerEntity,
      this.isPostReservationLoading});
  final Unit? unit;
  final bool isLoading;
  final bool isError;
  final SelectedContentType selectedContentType;
  final OfferEntity? offerEntity;
  final bool? isPostReservationLoading;

  @override
  List<Object?> get props => [unit, isLoading, isError, selectedContentType, offerEntity, isPostReservationLoading];

  UnitDetailsState copyWith(
      {Unit? unit,
      bool? isLoading,
      bool? isError,
      SelectedContentType? selectedContentType,
      OfferEntity? offerEntity,
      bool? isPostReservationLoading}) {
    return UnitDetailsState(
        isLoading: isLoading ?? this.isLoading,
        unit: unit ?? this.unit,
        isError: isError ?? this.isError,
        selectedContentType: selectedContentType ?? this.selectedContentType,
        offerEntity: offerEntity ?? this.offerEntity,
        isPostReservationLoading: isPostReservationLoading ?? this.isPostReservationLoading);
  }
}

enum SelectedContentType { overView, review }
