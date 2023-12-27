import 'package:owner/utils/const.dart';

class FilterQueries {
  List<int> minRooms;
  List<int> minBeds;
  String minGuest;
  String type;
  List<int> regions;
  String minPrice;
  String maxPrice;
  String orderBy;
  String orderType;
  int perPage;
  int page;
  String sortType;
  int mostPoplar;
  int escapePagination;
  int withModels;

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
      this.withModels = 0,
      this.sortType = highToLowPrice,
      this.escapePagination = 0});
}

enum UnitType { camp, chalet }
