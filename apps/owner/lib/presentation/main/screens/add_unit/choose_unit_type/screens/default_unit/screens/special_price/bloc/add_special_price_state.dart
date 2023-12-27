import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';

class AddSpecialPriceState extends Equatable {
  const AddSpecialPriceState({this.selectedPriceRanges});
  final List<PriceRange>? selectedPriceRanges;
  @override
  List<Object?> get props => [selectedPriceRanges];
  AddSpecialPriceState copyWith({List<PriceRange>? selectedPriceRanges}) {
    return AddSpecialPriceState(selectedPriceRanges: selectedPriceRanges ?? this.selectedPriceRanges);
  }
}

class InitialAddSpecialPriceState extends AddSpecialPriceState {
  const InitialAddSpecialPriceState() : super();
}
