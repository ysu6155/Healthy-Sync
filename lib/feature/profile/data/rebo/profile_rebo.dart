import 'dart:developer';


import 'package:dio/dio.dart';
import 'package:healthy_sync/core/network/dio_helper.dart';
import 'package:healthy_sync/core/network/end_points.dart';
import 'package:healthy_sync/core/service/local/shared_keys.dart';
import 'package:healthy_sync/core/service/local/shared_helper.dart';
import 'package:healthy_sync/feature/profile/data/models/profile/profile.dart';

class ProfileRepository {
  static Future<Profile> getProfileData() async {
    final response = await DioHelper.get(
      endPoints: EndPoints.profile,
      headers: {
        "Authorization": "Bearer ${SharedHelper.get(SharedKeys.kToken)}",
      },
    );
    if (response.statusCode == 200) {
      log("API Response: ${response.data}");
      return Profile.fromJson(response.data);
    } else {
      throw Exception("Failed to load profile");
    }
  }

  static Future<Response> updateProfile(FormData formData) async {
    return await DioHelper.post(
      endPoints: EndPoints.updateProfile,
      body: formData,
      headers: {
        "Authorization": "Bearer \${SharedHelper.get(SharedKeys.kToken)}",
      },
    );
  }

  static Future<Response> updatePassword(Map<String, dynamic> body) async {
    return await DioHelper.post(
      endPoints: EndPoints.updatePassword,
      body: body,
      headers: {
        "Authorization": "Bearer \${SharedHelper.get(SharedKeys.kToken)}",
      },
    );
  }
}

