import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  // void login(BuildContext context) {
  // if (formKey.currentState!.validate()) {
  // emit(LoginLoading());
  // Future.delayed(Duration(seconds: 2), () {
  // context.pushReplacement(TapBarScreen());
  //emit(LoginSuccess()); // Simulating API Call Success
  //});
  // }

  // }
  login(RegisterParams params) {
    if (formKey.currentState!.validate()) {
      emit(LoginLoading());
      AuthRepo.register(params).then((value) {
        if (value != null) {
          emit(LoginSuccess());
        } else {
          emit(LoginError("Failed to register"));
        }
      });
    }
  }
}
