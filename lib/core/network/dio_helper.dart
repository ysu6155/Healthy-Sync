import 'package:dio/dio.dart';
import 'package:healthy_sync/core/network/end_points.dart';

sealed class DioHelper {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: EndPoints.baseUrl,
      headers: {
        'Content-Type': 'application/json',
        "Accept": "application/json",
      },
    ),
  );

  static Future<Response> post({
    required String endPoints,
    Object? body,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await dio.post(
        endPoints,
        data: body,
        queryParameters: params,
        options: Options(headers: headers),
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> get({
    required String endPoints,
    Object? body,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await dio.get(
        endPoints,
        data: body,
        queryParameters: params,
        options: Options(headers: headers),
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> patch({
    required String endPoints,
    Object? body,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await dio.patch(
        endPoints,
        data: body,
        queryParameters: params,
        options: Options(headers: headers),
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> delete({
    required String endPoints,
    Object? body,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await dio.delete(
        endPoints,
        data: body,
        queryParameters: params,
        options: Options(headers: headers),
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> put({
    required String endPoints,
    Object? body,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await dio.put(
        endPoints,
        data: body,
        queryParameters: params,
        options: Options(headers: headers),
      );
    } catch (e) {
      rethrow;
    }
  }
}
