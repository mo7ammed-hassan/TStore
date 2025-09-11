import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late final Dio dio;

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint('➡️ [REQUEST] ${options.method} ${options.path}');
        debugPrint('Headers: ${options.headers}');
        debugPrint('Data: ${options.data}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint('✅ [RESPONSE] ${response.statusCode} ${response.data}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        debugPrint('❌ [ERROR] ${e.response?.statusCode} ${e.message}');
        return handler.next(e);
      },
    ));
  }

  Future<Response<T>> post<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? headers,
  }) {
    return dio.post<T>(
      url,
      data: data,
      options: Options(headers: headers),
    );
  }

  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return dio.get<T>(
      url,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  Future<Response<T>> delete<T>(
    String url, {
    Map<String, dynamic>? headers,
  }) {
    return dio.delete<T>(
      url,
      options: Options(headers: headers),
    );
  }
}
