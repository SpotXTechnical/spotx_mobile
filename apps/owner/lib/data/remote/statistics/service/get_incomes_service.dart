import 'package:owner/base/base_service.dart';
import 'package:owner/data/remote/statistics/model/income_entity.dart';
import 'package:owner/data/remote/statistics/model/statistics_filter.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/base_list_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

class GetIncomesService extends BaseService {
  Future<ApiResponse> getIncomes(int page, {StatisticsFilter? statisticsFilter}) async {
    Map<String, String> queryParams = <String, String>{};
    queryParams["page"] = page.toString();
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
        NetworkRequest(incomeApi, RequestMethod.get, headers: await getHeaders(), queryParams: queryParams);

    var result = await networkManager.perform(request);
    if (result.status == Status.OK) {
      result.data = BaseListResponse.fromJson(result.data, (json) => IncomeEntity.fromJson(json));
    }
    return result;
  }
}
