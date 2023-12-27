import 'package:spotx/base/base_service.dart';
import 'package:spotx/data/remote/unit/model/offer_entity.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/network/base_response.dart';
import 'package:spotx/utils/network/const.dart';
import 'package:spotx/utils/network/network_request.dart';

class GetOfferByIdService extends BaseService {
  Future<ApiResponse> getOfferById(String offerId) async {
    Map<String, String> queryParams = <String, String>{};
    NetworkRequest request =
        NetworkRequest("$offersApi/$offerId", RequestMethod.get, headers: await getHeaders(), queryParams: queryParams);

    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {
      result.data = BaseResponse.fromJson(result.data, (json) => OfferEntity.fromJson(json));
    }
    return result;
  }
}
