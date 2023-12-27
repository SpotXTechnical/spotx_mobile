import 'package:spotx/base/base_service.dart';
import 'package:spotx/data/remote/auth/models/forget_password_request_entity_entity.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/network/const.dart';
import 'package:spotx/utils/network/network_request.dart';
import 'package:spotx/utils/utils.dart';

class ForgetPasswordService extends BaseService{
  Future<ApiResponse> forgotPassword(String email) async{
    NetworkRequest request = NetworkRequest(forgetPassword, RequestMethod.post,
        headers: {"Accept-Language":isArabic ? 'ar':'en',},
        data: ForgetPasswordRequestEntityEntity(email: email).toJson()
    );
    return await networkManager.perform(request);
  }
}