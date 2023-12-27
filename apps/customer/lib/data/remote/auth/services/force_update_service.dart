import 'package:spotx/base/base_service.dart';
import 'package:spotx/data/remote/auth/models/force_update_entity.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/network/base_list_response.dart';
import 'package:spotx/utils/network/const.dart';
import 'package:spotx/utils/network/network_request.dart';
import 'package:spotx/utils/utils.dart';

class ForceUpdateService extends BaseService {
  Future<ApiResponse> checkForForceUpdates() async {
    NetworkRequest request = NetworkRequest(settings, RequestMethod.get, headers: {
      "X-API-KEY": "e06a233ce2c96fab67f5c2bdf02a2c5f70b25104",
      "Accept-Language": isArabic ? 'ar' : 'en',
    });
    var result = await networkManager.perform(request);
    if (result.status == Status.OK) {
      result.data = BaseListResponse.fromJson(result.data, (json) => ForceUpdateEntity.fromJson(json));
    }
    return result;
  }
}

// todo update this after api integration
const String driverAndroidForceUpdateVersion = 'picker_android_force_update_version';
const String driverIosForceUpdateVersion = 'picker_ios_force_update_version';
const String driverHuaweiForceUpdateVersion = 'picker_huawei_force_update_version';
