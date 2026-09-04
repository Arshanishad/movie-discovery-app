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
              'Accept': 'application/json',
            },
          ),
        ) {
    // Dio request/response logging in debug mode
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

    // Authentication and error logging
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] =
              'Bearer ${ApiConstants.tmdbToken}';

          options.headers['Accept'] = 'application/json';

          _logger.i(
            'REQUEST: ${options.method} ${options.uri}',
          );

          return handler.next(options);
        },

        onResponse: (response, handler) {
          _logger.i(
            'RESPONSE: ${response.statusCode} ${response.requestOptions.uri}',
          );

          return handler.next(response);
        },

        onError: (DioException e, handler) {
          _logger.e(
            'REQUEST FAILED\n'
            'Type: ${e.type}\n'
            'Message: ${e.message}\n'
            'URL: ${e.requestOptions.uri}\n'
            'Status: ${e.response?.statusCode}\n'
            'Response: ${e.response?.data}',
          );

          return handler.next(e);
        },
      ),
    );
  }

  // ------------------------------------------------------------
  // GET
  // ------------------------------------------------------------

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<T>(
        path.trim(),
        queryParameters: queryParameters,
      );

      return response;
    } on DioException catch (e) {
      _logger.e(
        'GET FAILED\n'
        'Path: ${path.trim()}\n'
        'Type: ${e.type}\n'
        'Message: ${e.message}',
      );

      rethrow;
    }
  }

  // ------------------------------------------------------------
  // POST
  // ------------------------------------------------------------

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post<T>(
        path.trim(),
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return response;
    } on DioException catch (e) {
      _logger.e(
        'POST FAILED\n'
        'Path: ${path.trim()}\n'
        'Type: ${e.type}\n'
        'Message: ${e.message}',
      );

      rethrow;
    }
  }

  // ------------------------------------------------------------
  // POST MULTIPART
  // ------------------------------------------------------------

  Future<Response<T>> postMultipart<T>(
    String path, {
    required FormData data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post<T>(
        path.trim(),
        data: data,
        queryParameters: queryParameters,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      return response;
    } on DioException catch (e) {
      _logger.e(
        'POST MULTIPART FAILED\n'
        'Path: ${path.trim()}\n'
        'Type: ${e.type}\n'
        'Message: ${e.message}',
      );

      rethrow;
    }
  }

  // ------------------------------------------------------------
  // PUT
  // ------------------------------------------------------------

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    Options? options,
  }) async {
    try {
      final response = await _dio.put<T>(
        path.trim(),
        data: data,
        options: (options ?? Options()).copyWith(
          headers: headers,
        ),
      );

      return response;
    } on DioException catch (e) {
      _logger.e(
        'PUT FAILED\n'
        'Path: ${path.trim()}\n'
        'Type: ${e.type}\n'
        'Message: ${e.message}',
      );

      rethrow;
    }
  }

  // ------------------------------------------------------------
  // DELETE
  // ------------------------------------------------------------

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path.trim(),
        data: data,
        queryParameters: queryParameters,
      );

      return response;
    } on DioException catch (e) {
      _logger.e(
        'DELETE FAILED\n'
        'Path: ${path.trim()}\n'
        'Type: ${e.type}\n'
        'Message: ${e.message}',
      );

      rethrow;
    }
  }

  // ------------------------------------------------------------
  // GET API DATA
  // ------------------------------------------------------------

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
