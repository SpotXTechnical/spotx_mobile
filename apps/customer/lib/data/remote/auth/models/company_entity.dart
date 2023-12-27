import 'package:spotx/generated/json/base/json_field.dart';
import 'package:spotx/generated/json/company_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class CompanyEntity {
	int? id;
	String? name;
	String? code;
	String? phone;
	String? email;

	CompanyEntity();

	factory CompanyEntity.fromJson(Map<String, dynamic> json) => $CompanyEntityFromJson(json);

	Map<String, dynamic> toJson() => $CompanyEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}