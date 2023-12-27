import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';

class EditSpecialPriceState extends Equatable {
  const EditSpecialPriceState({this.selectedPriceRanges, this.isLoading = false});
  final List<PriceRange>? selectedPriceRanges;
  final bool isLoading;
  @override
  List<Object?> get props => [selectedPriceRanges, isLoading];
  EditSpecialPriceState copyWith({List<PriceRange>? selectedPriceRanges, bool? isLoading}) {
    return EditSpecialPriceState(
        selectedPriceRanges: selectedPriceRanges ?? this.selectedPriceRanges, isLoading: isLoading ?? this.isLoading);
  }
}

class InitialAddSpecialPriceState extends EditSpecialPriceState {
  const InitialAddSpecialPriceState() : super();
}
