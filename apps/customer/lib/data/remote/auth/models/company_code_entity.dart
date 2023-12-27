import 'package:spotx/data/remote/auth/models/login_response_entity.dart';
import 'package:spotx/generated/json/base/json_field.dart';
import 'package:spotx/generated/json/company_code_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class CompanyCodeEntity {
	User? user;

	CompanyCodeEntity();

	factory CompanyCodeEntity.fromJson(Map<String, dynamic> json) => $CompanyCodeEntityFromJson(json);

	Map<String, dynamic> toJson() => $CompanyCodeEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}