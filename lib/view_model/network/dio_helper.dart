import 'package:dio/dio.dart';
import 'package:healthy_sync/view_model/network/end_points.dart';

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
    required String path,
    Object? body,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await dio.post(
        path,
        data: body,
        queryParameters: params,
        options: Options(
          headers: headers,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> get({
    required String path,
    Object? body,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await dio.get(
        path,
        data: body,
        queryParameters: params,
        options: Options(
          headers: headers,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> patch({
    required String path,
    Object? body,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await dio.patch(
        path,
        data: body,
        queryParameters: params,
        options: Options(
          headers: headers,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> delete({
    required String path,
    Object? body,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await dio.delete(
        path,
        data: body,
        queryParameters: params,
        options: Options(
          headers: headers,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> put({
    required String path,
    Object? body,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await dio.put(
        path,
        data: body,
        queryParameters: params,
        options: Options(
          headers: headers,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
