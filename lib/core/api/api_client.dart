import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:movie_discovery_app/core/constants/api_constants.dart';

class ApiClient {
  final Dio _dio;

  final Logger _logger = Logger(
    level: Level.debug,
  );

  ApiClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            connectTimeout: const Duration(seconds: 30),
            sendTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        ) {
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          requestHeader: true,
          responseHeader: true,
        ),
      );
    }

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = 'Bearer ${ApiConstants.tmdbToken}';

          _logger.i('Requesting: ${options.baseUrl}${options.path}');

          return handler.next(options);
        },
        onError: (DioException e, handler) {
          _logger.e(
            'Request FAILED: ${e.type} | ${e.message} | '
            'URL: ${e.requestOptions.baseUrl}${e.requestOptions.path}',
          );
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get<T>(
        path.trim(),
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      _logger.e('GET ${path.trim()} failed: ${e.type} - ${e.message}');
      rethrow;
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post<T>(
        path.trim(),
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      _logger.e('POST ${path.trim()} failed: ${e.type} - ${e.message}');
      rethrow;
    }
  }

  Future<Response<T>> postMultipart<T>(
    String path, {
    required FormData data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.post<T>(
        path.trim(),
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
    } on DioException catch (e) {
      _logger.e('POST Multipart ${path.trim()} failed: ${e.type} - ${e.message}');
      rethrow;
    }
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    Options? options,
  }) async {
    try {
      return await _dio.put<T>(
        path.trim(),
        data: data,
        options: (options ?? Options()).copyWith(
          headers: headers,
        ),
      );
    } on DioException catch (e) {
      _logger.e('PUT ${path.trim()} failed: ${e.type} - ${e.message}');
      rethrow;
    }
  }

  Future<dynamic> getApiData(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await get<dynamic>(
      path,
      queryParameters: queryParameters,
    );

    final data = response.data;

    if (data is String) {
      return jsonDecode(data);
    }

    return data;
  }
}

