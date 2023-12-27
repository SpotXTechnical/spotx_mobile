import 'package:owner/generated/json/base/json_convert_content.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';


PriceRange $PriceRangeFromJson(Map<String, dynamic> json) {
  final PriceRange priceRange = PriceRange();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    priceRange.id = id;
  }
  final String? from = jsonConvert.convert<String>(json['from']);
  if (from != null) {
    priceRange.from = from;
  }
  final String? to = jsonConvert.convert<String>(json['to']);
  if (to != null) {
    priceRange.to = to;
  }
  final DateTime? startDay = jsonConvert.convert<DateTime>(json['from']);
  if (startDay != null) {
    priceRange.startDay = startDay;
  }
  final DateTime? endDay = jsonConvert.convert<DateTime>(json['to']);
  if (endDay != null) {
    priceRange.endDay = endDay;
  }
  final int? isOffer = jsonConvert.convert<int>(json['is_offer']);
  if (isOffer != null) {
    priceRange.isOffer = isOffer;
  }
  final String? price = jsonConvert.convert<String>(json['price']);
  if (price != null) {
    priceRange.price = price;
  }
  return priceRange;
}

Map<String, dynamic> $PriceRangeToJson(PriceRange entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['from'] = entity.from;
  data['to'] = entity.to;
  data['from'] = entity.startDay?.toIso8601String();
  data['to'] = entity.endDay?.toIso8601String();
  data['is_offer'] = entity.isOffer;
  data['price'] = entity.price;
  return data;
}

extension PriceRangeExt on PriceRange {
  PriceRange copyWith({
    String? id,
    String? from,
    String? to,
    DateTime? startDay,
    DateTime? endDay,
    int? isOffer,
    String? price,
  }) {
    return PriceRange()
      ..id = id ?? this.id
      ..from = from ?? this.from
      ..to = to ?? this.to
      ..startDay = startDay ?? this.startDay
      ..endDay = endDay ?? this.endDay
      ..isOffer = isOffer ?? this.isOffer
      ..price = price ?? this.price;
  }
}