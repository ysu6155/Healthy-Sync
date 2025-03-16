import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:healthy_sync/core/service/local/shared_helper.dart';
import 'package:healthy_sync/feature/profile/data/rebo/profile_rebo.dart';
import 'package:healthy_sync/feature/welcome/presentation/screens/welcome/welcome_screen.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> getProfileData() async {
    emit(ProfileLoading());
    try {
      final response = await ProfileRepository.updateUser();
      emit(
        ProfileLoaded(
          name: response.user?.name ?? "",
          email: response.user?.email ?? "No Email",
          image: response.user?.profilePhoto ?? "",
          address: response.user?.role ?? "",
          city: response.user?.createdAt.toString() ?? "",
          phone: response.user?.v.toString() ?? "",
        ),
      );
    } catch (e) {
      log(e.toString());
      emit(ProfileError("Failed to load profile: $e"));
    }
  }

  Future<void> logout(BuildContext context) async {
    SharedHelper.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => WelcomeScreen()),
      (route) => false,
    );
  }

  Future<void> updateProfile(
    File? imageFile,
    TextEditingController name,
    TextEditingController phone,
    TextEditingController address,
  ) async {
    emit(ProfileUpdateLoading());
    try {
      Response response = await ProfileRepository.updateProfile({
        "name": name.text,
        "phone": phone.text,
        "role": address.text,
        if (imageFile != null)
          "profilePhoto": await MultipartFile.fromFile(
            imageFile.path,
            filename: "profile.jpg",
          ),
      });

      if (response.statusCode == 200) {
        emit(ProfileUpdateSuccess("Profile updated successfully!"));
        log("✅ Profile updated successfully!");
        name.clear();
        phone.clear();
        address.clear();
      } else {
        emit(ProfileUpdateError("Failed to update profile"));
        log("❌ Error: ${response.statusMessage}");
      }
    } catch (e) {
      log("❌ Exception: $e");
    }
  }

  Future<void> updatePassword() async {
    emit(ProfileUpdateLoading());
    try {
      final response = await ProfileRepository.updatePassword({
        "current_password": currentPasswordController.text,
        "new_password": newPasswordController.text,
        "new_password_confirmation": confirmPasswordController.text,
      });

      if (response.statusCode == 200) {
        emit(ProfileUpdateSuccess("Password updated successfully!"));
        log("Password updated successfully!");
        currentPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
      } else {
        emit(ProfileUpdateError("Failed to update password"));
        log("Error: ${response.statusMessage}");
      }
    } catch (e) {
      log("❌ Exception: $e");

      emit(ProfileError("Failed to update password"));
    }
  }
}
