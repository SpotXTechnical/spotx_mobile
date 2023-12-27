import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';

import '../../unit_details/bloc/unit_details_state.dart';

class CampDetailsState extends Equatable {
  const CampDetailsState({this.isLoading = false, this.unit, this.selectedContentType = SelectedContentType.overView});
  final Unit? unit;
  final bool isLoading;
  final SelectedContentType selectedContentType;

  @override
  List<Object?> get props => [unit, isLoading, selectedContentType];

  CampDetailsState copyWith({Unit? unit, bool? isLoading, bool? isError, SelectedContentType? selectedContentType}) {
    return CampDetailsState(
        isLoading: isLoading ?? this.isLoading,
        unit: unit ?? this.unit,
        selectedContentType: selectedContentType ?? this.selectedContentType);
  }
}
