import 'package:spotx/generated/json/meta.g.dart';

import 'package:spotx/generated/json/base/json_field.dart';

@JsonSerializable()
class Meta {
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) => $MetaFromJson(json);

  Map<String, dynamic> toJson() => $MetaToJson(this);

  @JSONField(name: "current_page")
  int? currentPage;
  int? from;
  @JSONField(name: "last_page")
  int? lastPage;
  String? path;
  @JSONField(name: "per_page")
  int? perPage;
  int? to;
  int? total;
}
