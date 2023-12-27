import 'package:owner/data/remote/add_unit/model/range.dart';

class EditedCalenderPriceRange {
  List<PriceRange>? list;
  PriceRange? editedElement;
  int? index;
  String? defaultPrice;
  String? unitId;

  EditedCalenderPriceRange(this.list, this.editedElement, this.index, this.defaultPrice, this.unitId);
}
