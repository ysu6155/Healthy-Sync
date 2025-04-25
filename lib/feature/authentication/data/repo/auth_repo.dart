import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:healthy_sync/core/network/dio_helper.dart';
import 'package:healthy_sync/core/network/end_points.dart';
import 'package:healthy_sync/feature/authentication/data/models/request/register_params.dart';
import 'package:healthy_sync/feature/authentication/data/models/response/login_user/login_user.dart';
import 'package:healthy_sync/feature/authentication/data/models/response/register_user/register_user.dart';

class AuthRepo {
  static Future<RegisterUser> register(RegisterParams params) async {
    try {
      var response = await DioHelper.post(
        endPoints: EndPoints.register,
        body: params.toJson(),
      );
      if (response.statusCode == 201) {
        log("✅ REGISTER SUCCESS");
        return RegisterUser.fromJson(response.data);
      } else {
        log("❌ REGISTER FAILED");
        log("📌 STATUS: ${response.statusCode}");
        log("📌 RESPONSE DATA: ${response.data}");
        throw Exception('Failed to register user');
      }
    } on DioException catch (e) {
      log("❌ DioException: REGISTER FAILED");
      log("📌 STATUS: ${e.response?.statusCode}");
      log("📌 RESPONSE DATA: ${e.response?.data}");
      log("📌 REQUEST DATA: ${e.requestOptions.data}");
      log("📌 HEADERS: ${e.requestOptions.headers}");
      throw Exception('DioException: ${e.message}');
    } catch (e) {
      log("❌ UNKNOWN EXCEPTION");
      log(e.toString());
      throw Exception(e);
    }
  }

  static Future<LoginUser> login(RegisterParams params) async {
    try {
      var response = await DioHelper.post(
        endPoints: EndPoints.login,
        body: params.toJson(),
      );
      if (response.statusCode == 200) {
        log(
          " yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy${response.data.toString()}",
        );
        return LoginUser.fromJson(response.data);
      } else {
        throw Exception('Failed to login ${response.data}');
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
