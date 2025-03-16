import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_sync/core/service/local/shared_keys.dart';
import 'package:healthy_sync/core/service/local/shared_helper.dart';
import 'package:healthy_sync/core/utils/extensions.dart';
import 'package:healthy_sync/feature/authentication/data/models/request/register_params.dart';
import 'package:healthy_sync/feature/authentication/data/repo/auth_repo.dart';
import 'package:healthy_sync/feature/authentication/presentation/cubit/login_cubit/login_state.dart';
import 'package:healthy_sync/feature/patients/presentation/screens/patient_home_nav.dart';

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
      log(response.user?.name ?? "5");
      log(response.user?.email ?? "13");
      log(response.token ?? "14");
      await SharedHelper.sava(SharedKeys.kToken, response.token);
      await SharedHelper.sava(SharedKeys.name, response.user?.name);
      await SharedHelper.sava(SharedKeys.email, response.user?.email);
      //await SharedHelper.sava(SharedKeys.image, response.data?.newUser?.profilePhoto);
      // await SharedHelper.sava(SharedKeys.role, response.data?.newUser?.role);

      emit(LoginSuccess());

      if (context.mounted) {
        context.pushAndRemoveUntil(const PatientHomeNavScreen());
      }
    } catch (e, stackTrace) {
      log("🔥 Login Error: $e");
      log("📌 StackTrace: $stackTrace");
      emit(LoginError("An error occurred. Please try again."));
    }
  }
}
