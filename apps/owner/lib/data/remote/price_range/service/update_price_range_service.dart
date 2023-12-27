import 'package:dio/dio.dart';
import 'package:owner/base/base_service.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

class UpdatePriceRangeService extends BaseService {
  Future<ApiResponse> updatePriceRange(PriceRange priceRange, String unitId) async {
    Map<String, dynamic> formData = {
      "id": priceRange.id,
      "from": priceRange.from,
      "to": priceRange.to,
      "price": priceRange.price,
      "_method": "put",
      "is_offer":priceRange.isOffer
    };

    FormData.fromMap(formData);

    NetworkRequest request = NetworkRequest('$getUnitsApi/$unitId/ranges/update', RequestMethod.post,
        headers: await getHeaders(), data: FormData.fromMap(formData));

    var result = await networkManager.perform(request);

    return result;
  }
}
