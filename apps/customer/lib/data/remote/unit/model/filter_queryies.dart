import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';
import 'package:spotx/generated/json/base/json_field.dart';
import 'package:spotx/generated/json/filter_queryies.g.dart';
import 'package:spotx/utils/const.dart';

@JsonSerializable()
class FilterQueries {
  List<int> minRooms;
  List<int> minBeds;
  String minGuest;
  String type;
  List<Region> regions;
  List<Region> mainRegionsOfSubRegions;
  String minPrice;
  String maxPrice;
  String orderBy;
  String orderType;
  int perPage;
  int page;
  String sortType;
  int mostPoplar;
  String? ownerId;
  bool isComingFromSearchScreenWithSubRegions;

  FilterQueries(
      {this.minRooms = const [],
      this.minBeds = const [],
      this.minGuest = "",
      this.type = "",
      this.regions = const [],
      this.minPrice = "",
      this.maxPrice = "",
      this.orderBy = orderByDefaultPrice,
      this.orderType = descOrderType,
      this.perPage = perPageCount,
      this.page = 1,
      this.mostPoplar = 0,
      this.ownerId,
      this.sortType = highToLowPrice,
      this.isComingFromSearchScreenWithSubRegions = false,
      this.mainRegionsOfSubRegions = const []});

  factory FilterQueries.fromJson(Map<String, dynamic> json) =>
      $FilterQueriesFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['minRooms'] = minRooms;
    data['minBeds'] = minBeds;
    data['minGuest'] = minGuest;
    data['type'] = type;
    data['regions'] = regions.map((v) => v.regionToJson(v)).toList();
    data['mainRegionsOfSubRegions'] =
        mainRegionsOfSubRegions.map((v) => v.regionToJson(v)).toList();
    data['minPrice'] = minPrice;
    data['maxPrice'] = maxPrice;
    data['orderBy'] = orderBy;
    data['orderType'] = orderType;
    data['perPage'] = perPage;
    data['page'] = page;
    data['sortType'] = sortType;
    data['mostPoplar'] = mostPoplar;
    data['ownerId'] = ownerId;
    data['isComingFromSearchScreenWithSubRegions'] =
        isComingFromSearchScreenWithSubRegions;
    return data;
  }
}