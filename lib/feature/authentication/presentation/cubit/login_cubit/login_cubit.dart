import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_sync/core/service/local/shared_keys.dart';
import 'package:healthy_sync/core/service/local/shared_helper.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/feature/authentication/data/models/request/register_params.dart';
import 'package:healthy_sync/feature/authentication/data/repo/auth_repo.dart';
import 'package:healthy_sync/feature/authentication/presentation/cubit/login_cubit/login_state.dart';
import 'package:healthy_sync/feature/doctors/home_nav/presentation/screens/doctor_home_nav.dart';
import 'package:healthy_sync/feature/lab/home_nav/presentation/screens/lab_nav.dart';
import 'package:healthy_sync/feature/patients/home_nav/presentation/screens/patient_home_nav.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool rememberMe = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(LoginPasswordVisibilityToggled(isPasswordVisible));
  }

  void toggleRememberMe(bool value) {
    rememberMe = value;
    emit(LoginRememberMeToggled(rememberMe));
  }

  Future<void> login(RegisterParams params, BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    emit(LoginLoading());
    try {
      final response = await AuthRepo.login(params);
      log(response.user.toString());
      log("Login response: ${response.user?.name}");
      log("Login response: ${response.user?.email}");
      log("Login response: ${response.user?.role}");
      await SharedHelper.sava(SharedKeys.role, response.user?.role);
      await SharedHelper.sava(SharedKeys.id, response.user?.id);
      await SharedHelper.sava(SharedKeys.kToken, response.token);
      //   await SharedHelper.sava(SharedKeys.gender, response.user?);
      emit(LoginSuccess());
      String role = response.user?.role ?? "patient";
      log("User role: $role");
      if (role == "patient") {
        context.pushAndRemoveUntil(const PatientHomeNavScreen());
      } else if (role == "doctor") {
        context.pushAndRemoveUntil(const DoctorHomeNavScreen());
      } else if (role == "lab") {
        context.pushAndRemoveUntil(const LabHomeNavScreen());
      }
    } catch (e, stackTrace) {
      log("🔥 Login Error: $e");
      log("📌 StackTrace: $stackTrace");
      emit(LoginError("An error occurred. Please try again."));
    }
  }
}
