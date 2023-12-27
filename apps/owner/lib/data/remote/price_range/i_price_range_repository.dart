import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/utils/network/api_response.dart';

abstract class IPriceRangeRepository {
  Future<ApiResponse> postPriceRange(PriceRange priceRange, String unitId);
  Future<ApiResponse> deletePriceRange(String rangeID);
  Future<ApiResponse> updatePriceRange(PriceRange priceRange, String unitId);
}
