class BaseResponse<T> {
  String? message;
  T? data;
  BaseResponse({this.message, this.data,});
  factory BaseResponse.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) serializationFunction) {
    return BaseResponse(
      message: json['message'],
      data: serializationFunction(json['data']),
    );
  }
}
