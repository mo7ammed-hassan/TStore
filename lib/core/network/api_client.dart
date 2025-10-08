import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// lazy singleton ///
class ApiClient {
  static ApiClient? _instance;
  late final Dio dio;

  static ApiClient get instance {
    _instance ??= ApiClient._internal();
    return _instance!;
  }

  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
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
