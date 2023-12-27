import 'package:dio/dio.dart';
import 'package:owner/base/base_service.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

class PostPriceRangeService extends BaseService {
  Future<ApiResponse> postPriceRange(PriceRange priceRange, String unitId) async {
    Map<String, dynamic> formData = {
      "from": priceRange.from,
      "to": priceRange.to,
      "price": priceRange.price,
      "is_offer":priceRange.isOffer
    };

    FormData.fromMap(formData);

    NetworkRequest request = NetworkRequest('$getUnitsApi/$unitId/ranges/create', RequestMethod.post,
        headers: await getHeaders(), data: FormData.fromMap(formData));

    var result = await networkManager.perform(request);

    return result;
  }
}
