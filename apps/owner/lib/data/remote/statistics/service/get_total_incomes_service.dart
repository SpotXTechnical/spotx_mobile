import 'package:owner/base/base_service.dart';
import 'package:owner/data/remote/statistics/model/total_icomes_entity.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/base_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

import '../model/statistics_filter.dart';

class GetTotalIncomesService extends BaseService {
  Future<ApiResponse> getTotalIncomes({StatisticsFilter? statisticsFilter}) async {
    Map<String, String> queryParams = <String, String>{};
    if (statisticsFilter != null) {
      queryParams["unit"] = statisticsFilter.unit!.id.toString();
      if (statisticsFilter.startDate != null) {
        queryParams["from"] = statisticsFilter.startDate.toString();
      }
      if (statisticsFilter.endData != null) {
        queryParams["to"] = statisticsFilter.endData.toString();
      }
      queryParams["regions[0]"] = statisticsFilter.region!.id.toString();
    }
    NetworkRequest request =
        NetworkRequest(totalIncomes, RequestMethod.get, headers: await getHeaders(), queryParams: queryParams);

    var result = await networkManager.perform(request);
    if (result.status == Status.OK) {
      result.data = BaseResponse.fromJson(result.data, (json) => TotalIncomesEntity.fromJson(json));
    }
    return result;
  }
}
