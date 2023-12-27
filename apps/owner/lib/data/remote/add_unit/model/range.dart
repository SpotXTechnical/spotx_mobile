import 'package:equatable/equatable.dart';
import 'package:owner/generated/json/range.g.dart';

import 'package:owner/generated/json/base/json_field.dart';

@JsonSerializable()
class PriceRange extends Equatable {
  factory PriceRange.fromJson(Map<String, dynamic> json) => $PriceRangeFromJson(json);

  Map<String, dynamic> toJson() => $PriceRangeToJson(this);
  String? id;
  String? from;
  String? to;
  @JSONField(name: "from")
  DateTime? startDay;
  @JSONField(name: "to")
  DateTime? endDay;
  @JSONField(name: "is_offer")
  int? isOffer;
  String? price;

  PriceRange({this.from, this.to, this.isOffer, this.price, this.startDay, this.endDay, this.id});

  static List<PriceRange> createNewListOfPriceRange(List<PriceRange>? oldList) {
    List<PriceRange>? newList = List.empty(growable: true);
    oldList?.forEach((element) {
      PriceRange newElement = PriceRange(
          id: element.id,
          price: element.price,
          startDay: element.startDay,
          endDay: element.endDay,
          isOffer: element.isOffer,
          from: element.from,
          to: element.to);
      newList.add(newElement);
    });
    return newList;
  }

  static bool isTheSameList(List<PriceRange>? oldList, List<PriceRange>? newList) {
    if (oldList?.length != newList?.length) {
      return false;
    }
    var isTheSameList = true;
    oldList?.asMap().forEach((index, value) => {
          if (!isTheSameElement(value, newList?.elementAt(index))) {isTheSameList = false}
        });

    return isTheSameList;
  }

  static bool isTheSameElement(PriceRange oldElement, PriceRange? newElement) {
    return (newElement != null &&
        oldElement.price == newElement.price &&
        oldElement.startDay!.isAtSameMomentAs(newElement.startDay!) &&
        oldElement.endDay!.isAtSameMomentAs(newElement.endDay!) &&
        oldElement.isOffer == newElement.isOffer &&
        oldElement.from == newElement.from &&
        oldElement.to == newElement.to &&
        oldElement.id == newElement.id);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [from, to, isOffer, price, startDay, endDay, id];
}
