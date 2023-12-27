import 'package:owner/generated/json/login_response_entity.g.dart';

import 'package:owner/generated/json/base/json_field.dart';

@JsonSerializable()
class LoginResponseEntity {
  LoginResponseEntity();

  factory LoginResponseEntity.fromJson(Map<String, dynamic> json) => $LoginResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => $LoginResponseEntityToJson(this);

  Token? token;
  User? user;
}

@JsonSerializable()
class Token {
  Token();

  factory Token.fromJson(Map<String, dynamic> json) => $TokenFromJson(json);

  Map<String, dynamic> toJson() => $TokenToJson(this);

  @JSONField(name: "access_token")
  String? accessToken;
  @JSONField(name: "expired_at")
  dynamic expiredAt;
  String? type;
}

@JsonSerializable()
class User {
  factory User.fromJson(Map<String, dynamic> json) => $UserFromJson(json);

  Map<String, dynamic> toJson() => $UserToJson(this);

  int? id;
  String? name;
  String? email;
  @JSONField(name: "email_verified_at")
  dynamic emailVerifiedAt;
  String? phone;
  @JSONField(name: "phone_verified_at")
  dynamic phoneVerifiedAt;
  dynamic image;
  @JSONField(name: "national_id")
  String? nationalId;
  @JSONField(name: "whatsapp")
  String? whatsApp;
  String? type;
  @JSONField(name: "notifications_count")
  int? notificationCount;

  User(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.phone,
      this.phoneVerifiedAt,
      this.image,
      this.nationalId,
      this.whatsApp,
      this.type});

  static User? createNewElement(User? oldElement) {
    if (oldElement != null) {
      return User(
          id: oldElement.id,
          name: oldElement.name,
          email: oldElement.email,
          emailVerifiedAt: oldElement.emailVerifiedAt,
          phone: oldElement.phone,
          phoneVerifiedAt: oldElement.phoneVerifiedAt,
          image: oldElement.image,
          nationalId: oldElement.nationalId,
          whatsApp: oldElement.whatsApp,
          type: oldElement.type);
    }
    return null;
  }
}
