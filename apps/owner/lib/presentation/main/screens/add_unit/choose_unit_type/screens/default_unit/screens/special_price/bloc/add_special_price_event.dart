import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';

abstract class AddSpecialPriceEvent extends Equatable {}

class AddPriceRangesListEvent extends AddSpecialPriceEvent {
  final List<PriceRange>? selectedPriceRanges;
  AddPriceRangesListEvent(this.selectedPriceRanges);
  @override
  List<Object?> get props => [selectedPriceRanges];
}

class DeletePriceRangeEvent extends AddSpecialPriceEvent {
  final PriceRange priceRange;
  DeletePriceRangeEvent(this.priceRange);
  @override
  List<Object?> get props => [priceRange];
}
