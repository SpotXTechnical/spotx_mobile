import 'package:owner/data/remote/auth/models/login_response_entity.dart';
import 'package:owner/generated/json/base/json_convert_content.dart';
import 'package:owner/data/remote/auth/models/register_response_entity.dart';


RegisterResponseEntity $RegisterResponseEntityFromJson(
    Map<String, dynamic> json) {
  final RegisterResponseEntity registerResponseEntity = RegisterResponseEntity();
  final Token? token = jsonConvert.convert<Token>(json['token']);
  if (token != null) {
    registerResponseEntity.token = token;
  }
  final User? user = jsonConvert.convert<User>(json['user']);
  if (user != null) {
    registerResponseEntity.user = user;
  }
  return registerResponseEntity;
}

Map<String, dynamic> $RegisterResponseEntityToJson(
    RegisterResponseEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['token'] = entity.token?.toJson();
  data['user'] = entity.user?.toJson();
  return data;
}

extension RegisterResponseEntityExt on RegisterResponseEntity {
  RegisterResponseEntity copyWith({
    Token? token,
    User? user,
  }) {
    return RegisterResponseEntity()
      ..token = token ?? this.token
      ..user = user ?? this.user;
  }
}

RegisterResponseEntityDataToken $RegisterResponseEntityDataTokenFromJson(
    Map<String, dynamic> json) {
  final RegisterResponseEntityDataToken registerResponseEntityDataToken = RegisterResponseEntityDataToken();
  final String? accessToken = jsonConvert.convert<String>(json['access_token']);
  if (accessToken != null) {
    registerResponseEntityDataToken.accessToken = accessToken;
  }
  final dynamic expiredAt = json['expired_at'];
  if (expiredAt != null) {
    registerResponseEntityDataToken.expiredAt = expiredAt;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    registerResponseEntityDataToken.type = type;
  }
  return registerResponseEntityDataToken;
}

Map<String, dynamic> $RegisterResponseEntityDataTokenToJson(
    RegisterResponseEntityDataToken entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['access_token'] = entity.accessToken;
  data['expired_at'] = entity.expiredAt;
  data['type'] = entity.type;
  return data;
}

extension RegisterResponseEntityDataTokenExt on RegisterResponseEntityDataToken {
  RegisterResponseEntityDataToken copyWith({
    String? accessToken,
    dynamic expiredAt,
    String? type,
  }) {
    return RegisterResponseEntityDataToken()
      ..accessToken = accessToken ?? this.accessToken
      ..expiredAt = expiredAt ?? this.expiredAt
      ..type = type ?? this.type;
  }
}