import 'dart:convert';
import 'package:movie_discovery_app/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> handleLogout403() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  if (token == null) return;
  await prefs.remove('token');
  await prefs.remove('userId');
}

class ApiClient {
  final Dio _dio;

  final Logger _logger = Logger(level: kDebugMode ? Level.debug : Level.off);

  ApiClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: const Duration(seconds: 60),
          sendTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
    'Bearer ${const String.fromEnvironment('TMDB_TOKEN')}',
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
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token');
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          final statusCode = e.response?.statusCode;
          if (statusCode == 401 || statusCode == 403) {
            await handleLogout403();
          }
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
      final response = await _dio.get<T>(
        path.trim(),
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      if (kDebugMode) {
        _logger.e('GET ${path.trim()} failed: ${e.message}');
      }
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
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      if (kDebugMode) {
        _logger.e('POST $path failed: ${e.message}');
      }
      rethrow;
    }
  }

  Future<Response<T>> postMultipart<T>(
    String path, {
    required FormData data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );
      return response;
    } on DioException catch (e) {
      if (kDebugMode) {
        _logger.e('POST Multipart $path failed: ${e.message}');
      }
      rethrow;
    }
  }

  Future<dynamic> getApiData(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await get(path, queryParameters: queryParameters);
    final data = response.data;
    if (data is String) {
      return jsonDecode(data);
    } else {
      return data;
    }
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    Options? options,
  }) async {
    return await _dio.put(
      path,
      data: data,
      options: (options ?? Options()).copyWith(headers: headers),
    );
  }
}
