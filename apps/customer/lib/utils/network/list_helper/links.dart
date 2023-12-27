import 'package:spotx/generated/json/base/json_field.dart';
import 'package:spotx/generated/json/links.g.dart';

@JsonSerializable()
class Links {
  Links();

  factory Links.fromJson(Map<String, dynamic> json) => $LinksFromJson(json);

  Map<String, dynamic> toJson() => $LinksToJson(this);

  String? first;
  String? last;
  String? prev;
  String? next;
}
