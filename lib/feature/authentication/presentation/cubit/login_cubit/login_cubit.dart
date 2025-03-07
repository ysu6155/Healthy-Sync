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
import 'package:healthy_sync/feature/layout/presentation/screens/layout/layout_screen.dart';

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

      await SharedHelper.sava(SharedKeys.kToken, response.data?.token);
       await SharedHelper.sava(SharedKeys.name, response.data?.user?.name);
       await SharedHelper.sava(SharedKeys.email, response.data?.user?.email);
        await SharedHelper.sava(SharedKeys.image, response.data?.user?.image);
      
      emit(LoginSuccess());

      if (context.mounted) {
        context.pushAndRemoveUntil(const TapBarScreen());
      }
        } catch (e, stackTrace) {
      log("🔥 Login Error: $e");
      log("📌 StackTrace: $stackTrace");
      emit(LoginError("An error occurred. Please try again."));
    }
  }
}
