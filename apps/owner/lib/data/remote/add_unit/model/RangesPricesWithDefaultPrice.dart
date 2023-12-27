import 'package:owner/data/remote/add_unit/model/range.dart';

class RangesPricesWithDefaultPrice {
  final List<PriceRange>? ranges;
  final String defaultPrice;
  final String? unitId;

  RangesPricesWithDefaultPrice(this.ranges, this.defaultPrice, this.unitId);
}
