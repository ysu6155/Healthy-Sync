import 'dart:developer';

import 'package:healthy_sync/core/network/dio_helper.dart';
import 'package:healthy_sync/core/network/end_points.dart';
import 'package:healthy_sync/feature/authentication/data/models/request/register_params.dart';
import 'package:healthy_sync/feature/authentication/data/models/response/login_response/login_response.dart';

import '../models/response/user/user.dart';

class AuthRepo {
  static Future<User> register(RegisterParams params) async {
    try {
      var response = await DioHelper.post(
        endPoints: EndPoints.register,
        body: params.toJson(),
      );
      if (response.statusCode == 201) {
        return User.fromJson(response.data);
      } else {
        throw Exception('Failed to register ${response.data}');
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  static Future<LoginResponse> login(RegisterParams params) async {
    try {
      var response = await DioHelper.post(
        endPoints: EndPoints.login,
        body: params.toJson(),
      );
      if (response.statusCode == 200) {
         log( response.data.toString());
        return LoginResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to login ${response.data}');
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
