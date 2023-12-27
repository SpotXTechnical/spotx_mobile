import 'package:spotx/base/base_service.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/network/base_list_response.dart';
import 'package:spotx/utils/network/const.dart';
import 'package:spotx/utils/network/network_request.dart';

class RemoveFromFavouriteService extends BaseService {
  Future<ApiResponse> removeFromFavourite(int id) async {
    NetworkRequest request =
        NetworkRequest(favouriteApi + "/" + id.toString(), RequestMethod.delete, headers: await getHeaders());

    var result = await networkManager.perform(request);

    return result;
  }
}
