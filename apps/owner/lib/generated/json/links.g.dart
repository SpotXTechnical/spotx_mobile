import 'package:owner/generated/json/base/json_convert_content.dart';
import 'package:owner/utils/network/list_helper/links.dart';

Links $LinksFromJson(Map<String, dynamic> json) {
  final Links links = Links();
  final String? first = jsonConvert.convert<String>(json['first']);
  if (first != null) {
    links.first = first;
  }
  final String? last = jsonConvert.convert<String>(json['last']);
  if (last != null) {
    links.last = last;
  }
  final String? prev = jsonConvert.convert<String>(json['prev']);
  if (prev != null) {
    links.prev = prev;
  }
  final String? next = jsonConvert.convert<String>(json['next']);
  if (next != null) {
    links.next = next;
  }
  return links;
}

Map<String, dynamic> $LinksToJson(Links entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['first'] = entity.first;
  data['last'] = entity.last;
  data['prev'] = entity.prev;
  data['next'] = entity.next;
  return data;
}

extension LinksExt on Links {
  Links copyWith({
    String? first,
    String? last,
    String? prev,
    String? next,
  }) {
    return Links()
      ..first = first ?? this.first
      ..last = last ?? this.last
      ..prev = prev ?? this.prev
      ..next = next ?? this.next;
  }
}