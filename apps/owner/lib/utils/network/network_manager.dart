import 'dart:io';

import 'package:alice/alice.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/application_error.dart';
import 'package:owner/utils/network/const.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'network_request.dart';

class NetworkManager {
  final Dio _dio = Dio();
  NetworkManager() {
    initDio();
  }

  void initDio() {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
    _dio.options.baseUrl = baseUrl;

    _dio.interceptors.add(InterceptorsWrapper(onRequest: (
      RequestOptions options,
      RequestInterceptorHandler handler,
    ) {
      // Authorization
      final bool isAuthorized = options.extra['isAuthorized'] as bool;
      if (isAuthorized) {
        // todo add authorization header
        // final String token = Get.find<SharedPreferencesService>().token;
        // options.headers['Authorization'] = 'Bearer $token';
      }
      // Language
      // todo add language interceptor
      /*final AppLocale locale = Get.find<LocalizationService>().currentLocale;
          if (locale.languageCode != null) {
            options.headers['Accept-Language'] = locale.languageCode;
          }*/
      return handler.next(options);
    }));
    if(kDebugMode) {
      _dio.interceptors.add(
          PrettyDioLogger(
              requestHeader: true,
              requestBody: true,
              responseBody: true,
              responseHeader: true,
              compact: false
          )
      );
      Alice alice = Alice(navigatorKey: navigationKey, notificationIcon: '@mipmap/launcher_icon');
      _dio.interceptors.add(alice.getDioInterceptor());
    }
  }

  Future<ApiResponse> perform(NetworkRequest request) async {
    try {
      final Response<dynamic> response = await _dio.request<dynamic>(
        request.url,
        data: request.data,
        queryParameters: request.queryParams,
        options: _getOptions(request),
      );
      return ApiResponse.success(response.data);
    } catch (e) {
      return ApiResponse.failed(getApplicationErrorFromDioError(e as DioError));
    }
  }

  Options _getOptions(NetworkRequest request) {
    return Options(
      headers: request.headers,
      method: request.method.name,
      extra: <String, dynamic>{
        'isAuthorized': request.isAuthorized
      }, // read this later in interceptor to send token if needed
    );
  }

  ApplicationError getApplicationErrorFromDioError(DioError dioError) {
    ErrorType errorType;
    String errorMsg = "Network error";
    dynamic extra;
    if (dioError.response?.data != null && dioError.response?.data is Map) {
      errorMsg = dioError.response?.data["message"] ?? "Network error";
      extra = dioError.response?.data["errors"];
    }
    if (dioError.response?.statusCode == 401) {
      errorType = Unauthorized();
    } else if (dioError.response?.statusCode == 404) {
      errorType = ResourceNotFound();
    } else if(dioError.response?.statusCode == 426) {
      errorType = UpdateRequired();
    } else {
      errorType = UnExpected();
    }
    return ApplicationError(type: errorType, errorMsg: errorMsg, extra: extra);
  }
}
