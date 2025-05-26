import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:healthy_sync/core/network/dio_helper.dart';
import 'package:healthy_sync/core/network/end_points.dart';
import 'package:healthy_sync/core/service/local/shared_keys.dart';
import 'package:healthy_sync/core/service/local/shared_helper.dart';
import 'package:healthy_sync/feature/patients/profile/data/models/profile/profile.dart';
import 'package:healthy_sync/feature/patients/profile/data/models/update_user/update_user.dart';

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

  static Future<Response> updateProfile(Map<String, dynamic> body) async {
    return await DioHelper.put(
      endPoints: EndPoints.updateUser,
      body: body,
      headers: {
        "Authorization": "Bearer ${SharedHelper.get(SharedKeys.kToken)}",
      },
    );
  }

  static Future<Response> updatePassword(Map<String, dynamic> body) async {
    return await DioHelper.post(
      endPoints: EndPoints.updatePassword,
      body: body,
      headers: {
        "Authorization": "Bearer ${SharedHelper.get(SharedKeys.kToken)}",
      },
    );
  }

  static Future<UpdateUser> updateUser() async {
    final response = await DioHelper.put(
      endPoints: EndPoints.updateUser,
      headers: {
        "Authorization": "Bearer ${SharedHelper.get(SharedKeys.kToken)}",
      },
    );
    if (response.statusCode == 200) {
      log("API Response: ${response.data}");
      return UpdateUser.fromJson(response.data);
    } else {
      throw Exception("Failed to load profile");
    }
  }
}

final profile = {
  'id': '1',
  'name': SharedHelper.get(SharedKeys.name) ?? "youssef",
  'specialization':
      SharedHelper.get(SharedKeys.role) == "admin" ? "معمل" : "طبيب عام",
  'gender': SharedHelper.get(SharedKeys.gender) ?? "male",
  "image": SharedHelper.get(SharedKeys.image) ??
      "https://b.top4top.io/p_3401vpliv1.jpg",
  'age': '45 سنة',
  'birthDate': SharedHelper.get(SharedKeys.dateOfBirth) ?? "2025-05-26",
  'phone': SharedHelper.get(SharedKeys.phone) ?? "01090438638",
  'email': SharedHelper.get(SharedKeys.email) ?? "youssef@example.com",
  'bloodType': 'B+',
};
