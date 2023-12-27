import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/data/remote/price_range/service/delete_price_range_service.dart';
import 'package:owner/data/remote/price_range/service/post_price_range_service.dart';
import 'package:owner/data/remote/price_range/service/update_price_range_service.dart';
import 'package:owner/utils/network/api_response.dart';

import 'i_price_range_repository.dart';

class PriceRangeRepository implements IPriceRangeRepository {
  final PostPriceRangeService _postPriceRangeService = PostPriceRangeService();
  final DeletePriceRangeService _deletePriceRange = DeletePriceRangeService();
  final UpdatePriceRangeService _updatePriceRangeService = UpdatePriceRangeService();

  @override
  Future<ApiResponse> postPriceRange(PriceRange priceRange, String unitId) {
    return _postPriceRangeService.postPriceRange(priceRange, unitId);
  }

  @override
  Future<ApiResponse> deletePriceRange(String rangeId) {
    return _deletePriceRange.deletePriceRange(rangeId);
  }

  @override
  Future<ApiResponse> updatePriceRange(PriceRange priceRange, String unitId) {
    return _updatePriceRangeService.updatePriceRange(priceRange, unitId);
  }
}
