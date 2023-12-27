import 'package:owner/base/base_service.dart';
import 'package:owner/data/remote/add_unit/model/filter_queryies.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/base_list_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

class GetUnitsService extends BaseService {
  Future<ApiResponse> getUnits(FilterQueries filterQueries) async {
    Map<String, String> queryParams = buildQueryParamsList(filterQueries);
    NetworkRequest request = NetworkRequest(getUnitsApi, RequestMethod.get, headers: await getHeaders(), queryParams: queryParams);

    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {
      result.data = BaseListResponse.fromJson(result.data, (json) => Unit.fromJson(json));
    }
    return result;
  }

  Map<String, String> buildQueryParamsList(FilterQueries filterQueries) {
    Map<String, String> queryParams = <String, String>{};
    filterQueries.minGuest != "" ? queryParams["guest"] = filterQueries.minGuest : "";
    filterQueries.type != "" ? queryParams["type"] = filterQueries.type : "";
    filterQueries.minPrice != "" ? queryParams["price[from]"] = filterQueries.minPrice : "";
    filterQueries.maxPrice != "" ? queryParams["price[to]"] = filterQueries.maxPrice : "";
    filterQueries.orderType != "" ? queryParams["order_type"] = filterQueries.orderType : "";
    filterQueries.orderBy != "" ? queryParams["order_by"] = filterQueries.orderBy : "";
    queryParams["per_page"] = filterQueries.perPage.toString();
    queryParams["page"] = filterQueries.page.toString();
    queryParams["most_popular"] = filterQueries.mostPoplar.toString();
    queryParams["with_models"] = filterQueries.withModels.toString();
    queryParams["escape_pagination"] = filterQueries.escapePagination.toString();
    filterQueries.minBeds.asMap().forEach((key, value) {
      queryParams["beds[$key]"] = value.toString();
    });
    filterQueries.minRooms.asMap().forEach((key, value) {
      queryParams["rooms[$key]"] = value.toString();
    });
    filterQueries.regions.asMap().forEach((key, value) {
      queryParams["regions[$key]"] = value.toString();
    });
    return queryParams;
  }
}
