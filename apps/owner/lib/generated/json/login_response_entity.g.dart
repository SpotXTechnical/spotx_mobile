import 'package:owner/generated/json/base/json_convert_content.dart';
import 'package:owner/data/remote/auth/models/login_response_entity.dart';

LoginResponseEntity $LoginResponseEntityFromJson(Map<String, dynamic> json) {
  final LoginResponseEntity loginResponseEntity = LoginResponseEntity();
  final Token? token = jsonConvert.convert<Token>(json['token']);
  if (token != null) {
    loginResponseEntity.token = token;
  }
  final User? user = jsonConvert.convert<User>(json['user']);
  if (user != null) {
    loginResponseEntity.user = user;
  }
  return loginResponseEntity;
}

Map<String, dynamic> $LoginResponseEntityToJson(LoginResponseEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['token'] = entity.token?.toJson();
  data['user'] = entity.user?.toJson();
  return data;
}

extension LoginResponseEntityExt on LoginResponseEntity {
  LoginResponseEntity copyWith({
    Token? token,
    User? user,
  }) {
    return LoginResponseEntity()
      ..token = token ?? this.token
      ..user = user ?? this.user;
  }
}

Token $TokenFromJson(Map<String, dynamic> json) {
  final Token token = Token();
  final String? accessToken = jsonConvert.convert<String>(json['access_token']);
  if (accessToken != null) {
    token.accessToken = accessToken;
  }
  final dynamic expiredAt = json['expired_at'];
  if (expiredAt != null) {
    token.expiredAt = expiredAt;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    token.type = type;
  }
  return token;
}

Map<String, dynamic> $TokenToJson(Token entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['access_token'] = entity.accessToken;
  data['expired_at'] = entity.expiredAt;
  data['type'] = entity.type;
  return data;
}

extension TokenExt on Token {
  Token copyWith({
    String? accessToken,
    dynamic expiredAt,
    String? type,
  }) {
    return Token()
      ..accessToken = accessToken ?? this.accessToken
      ..expiredAt = expiredAt ?? this.expiredAt
      ..type = type ?? this.type;
  }
}

User $UserFromJson(Map<String, dynamic> json) {
  final User user = User();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    user.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    user.name = name;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    user.email = email;
  }
  final dynamic emailVerifiedAt = json['email_verified_at'];
  if (emailVerifiedAt != null) {
    user.emailVerifiedAt = emailVerifiedAt;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    user.phone = phone;
  }
  final dynamic phoneVerifiedAt = json['phone_verified_at'];
  if (phoneVerifiedAt != null) {
    user.phoneVerifiedAt = phoneVerifiedAt;
  }
  final dynamic image = json['image'];
  if (image != null) {
    user.image = image;
  }
  final String? nationalId = jsonConvert.convert<String>(json['national_id']);
  if (nationalId != null) {
    user.nationalId = nationalId;
  }
  final String? whatsApp = jsonConvert.convert<String>(json['whatsapp']);
  if (whatsApp != null) {
    user.whatsApp = whatsApp;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    user.type = type;
  }
  final int? notificationCount = jsonConvert.convert<int>(
      json['notifications_count']);
  if (notificationCount != null) {
    user.notificationCount = notificationCount;
  }
  return user;
}

Map<String, dynamic> $UserToJson(User entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['email'] = entity.email;
  data['email_verified_at'] = entity.emailVerifiedAt;
  data['phone'] = entity.phone;
  data['phone_verified_at'] = entity.phoneVerifiedAt;
  data['image'] = entity.image;
  data['national_id'] = entity.nationalId;
  data['whatsapp'] = entity.whatsApp;
  data['type'] = entity.type;
  data['notifications_count'] = entity.notificationCount;
  return data;
}

extension UserExt on User {
  User copyWith({
    int? id,
    String? name,
    String? email,
    dynamic emailVerifiedAt,
    String? phone,
    dynamic phoneVerifiedAt,
    dynamic image,
    String? nationalId,
    String? whatsApp,
    String? type,
    int? notificationCount,
  }) {
    return User()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..email = email ?? this.email
      ..emailVerifiedAt = emailVerifiedAt ?? this.emailVerifiedAt
      ..phone = phone ?? this.phone
      ..phoneVerifiedAt = phoneVerifiedAt ?? this.phoneVerifiedAt
      ..image = image ?? this.image
      ..nationalId = nationalId ?? this.nationalId
      ..whatsApp = whatsApp ?? this.whatsApp
      ..type = type ?? this.type
      ..notificationCount = notificationCount ?? this.notificationCount;
  }
}