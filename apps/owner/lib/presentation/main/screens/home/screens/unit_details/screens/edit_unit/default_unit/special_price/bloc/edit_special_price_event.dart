import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';

abstract class EditSpecialPriceEvent extends Equatable {}

class AddPriceRangesListEvent extends EditSpecialPriceEvent {
  final List<PriceRange>? selectedPriceRanges;
  AddPriceRangesListEvent(
    this.selectedPriceRanges,
  );
  @override
  List<Object?> get props => [selectedPriceRanges];
}

class DeletePriceRangeEvent extends EditSpecialPriceEvent {
  final PriceRange priceRange;
  DeletePriceRangeEvent(this.priceRange);
  @override
  List<Object?> get props => [priceRange];
}
