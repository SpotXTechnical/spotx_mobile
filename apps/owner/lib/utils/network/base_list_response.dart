import 'package:owner/utils/network/list_helper/links.dart';
import 'package:owner/utils/network/list_helper/meta.dart';

class BaseListResponse<T> {
  String? message;
  dynamic error;
  List<T>? data;
  Meta? meta;
  Links? links;
  BaseListResponse({this.message, this.data, this.error, this.meta, this.links});
  factory BaseListResponse.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) serializationFunction) {
    return BaseListResponse(
      message: json['message'],
      error: json['error'],
      data: List.from((json['data'] as List).map((e) => serializationFunction(e))),
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      links: json['links'] != null ? Links.fromJson(json['links']) : null,
    );
  }
}
