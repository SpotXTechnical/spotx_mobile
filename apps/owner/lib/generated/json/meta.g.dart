import 'package:owner/generated/json/base/json_convert_content.dart';
import 'package:owner/utils/network/list_helper/meta.dart';

Meta $MetaFromJson(Map<String, dynamic> json) {
  final Meta meta = Meta();
  final int? currentPage = jsonConvert.convert<int>(json['current_page']);
  if (currentPage != null) {
    meta.currentPage = currentPage;
  }
  final int? from = jsonConvert.convert<int>(json['from']);
  if (from != null) {
    meta.from = from;
  }
  final int? lastPage = jsonConvert.convert<int>(json['last_page']);
  if (lastPage != null) {
    meta.lastPage = lastPage;
  }
  final String? path = jsonConvert.convert<String>(json['path']);
  if (path != null) {
    meta.path = path;
  }
  final int? perPage = jsonConvert.convert<int>(json['per_page']);
  if (perPage != null) {
    meta.perPage = perPage;
  }
  final int? to = jsonConvert.convert<int>(json['to']);
  if (to != null) {
    meta.to = to;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    meta.total = total;
  }
  return meta;
}

Map<String, dynamic> $MetaToJson(Meta entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['current_page'] = entity.currentPage;
  data['from'] = entity.from;
  data['last_page'] = entity.lastPage;
  data['path'] = entity.path;
  data['per_page'] = entity.perPage;
  data['to'] = entity.to;
  data['total'] = entity.total;
  return data;
}

extension MetaExt on Meta {
  Meta copyWith({
    int? currentPage,
    int? from,
    int? lastPage,
    String? path,
    int? perPage,
    int? to,
    int? total,
  }) {
    return Meta()
      ..currentPage = currentPage ?? this.currentPage
      ..from = from ?? this.from
      ..lastPage = lastPage ?? this.lastPage
      ..path = path ?? this.path
      ..perPage = perPage ?? this.perPage
      ..to = to ?? this.to
      ..total = total ?? this.total;
  }
}