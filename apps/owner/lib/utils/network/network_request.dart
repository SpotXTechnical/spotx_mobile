enum RequestMethod { get, post, put, delete }
enum RequestDataType { json, formData }

extension RequestMethodExtension on RequestMethod {
  String get name {
    switch (this) {
      case RequestMethod.get:
        return 'get';
      case RequestMethod.post:
        return 'post';
      case RequestMethod.put:
        return 'put';
      case RequestMethod.delete:
        return 'delete';
    }
  }
}

class NetworkRequest {
  NetworkRequest(
  this.url,
  this.method, {
    this.data,
    this.dataType = RequestDataType.json,
    this.queryParams,
    this.headers,
    this.isAuthorized = false
  });

  final String url;
  final RequestMethod method;
  dynamic data;
  RequestDataType dataType;
  Map<String, String>? queryParams;
  Map<String, String>? headers;
  bool isAuthorized;
}