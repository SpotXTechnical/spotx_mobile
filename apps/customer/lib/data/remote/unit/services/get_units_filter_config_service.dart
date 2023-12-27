import 'package:spotx/base/base_service.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';
import 'package:spotx/data/remote/unit/model/unit_filter_config_entity.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/network/base_list_response.dart';
import 'package:spotx/utils/network/base_response.dart';
import 'package:spotx/utils/network/const.dart';
import 'package:spotx/utils/network/network_request.dart';

class GetUnitsFilterConfigService extends BaseService {
  Future<ApiResponse> getUnitsFilterConfig() async {
    //getUnitFilterConfig
    NetworkRequest request = NetworkRequest(getUnitsFilterConfigApi, RequestMethod.get, headers: await getHeaders());

    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {
      result.data = BaseResponse.fromJson(result.data, (json) => UnitFilterConfigEntity.fromJson(json));
    }

    return result;
  }

  Future<List<ApiResponse>> getFilterData() async {
    List<ApiResponse> results = List.empty(growable: true);
    results.add(await getRegions(0));
    results.add(await getUnitsFilterConfig());
    return results;
  }

  Future<ApiResponse> getRegions(int withSubRegion) async {
    Map<String, String> queryParams = <String, String>{};
    queryParams["with_sub"] = withSubRegion.toString();
    NetworkRequest request =
        NetworkRequest(getRegionsApi, RequestMethod.get, headers: await getHeaders(), queryParams: queryParams);

    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {
      result.data = BaseListResponse.fromJson(result.data, (json) => Region.fromJson(json));
    }
    return result;
  }
}
