import 'package:spotx/base/base_service.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/network/base_list_response.dart';
import 'package:spotx/utils/network/const.dart';
import 'package:spotx/utils/network/network_request.dart';

class GetFavouritesService extends BaseService {
  Future<ApiResponse> getFavourites(int page) async {
    Map<String, String> queryParams = <String, String>{};
    queryParams["page"] = page.toString();

    NetworkRequest request = NetworkRequest(favouriteApi, RequestMethod.get, headers: await getHeaders(), queryParams: queryParams);

    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {
      result.data = BaseListResponse.fromJson(result.data, (json) => Unit.fromJson(json));
    }
    return result;
  }
}
