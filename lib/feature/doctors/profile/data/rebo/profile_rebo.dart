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
  'name': 'يوسف شعبان',
  'specialization': 'طبيب عام',
  'gender': 'ذكر',
  "image": "https://b.top4top.io/p_3401vpliv1.jpg",
  'age': '45 سنة',
  'birthDate': '45',
  'phone': '01090438638',
  'email': 'Youssif@example.com',
  'bloodType': 'B+',
};
