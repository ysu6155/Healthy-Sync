import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_sync/feature/authentication/presentation/reset_password/cubit/reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isPasswordVisible = false;

  ResetPasswordCubit() : super(ResetPasswordInitial());

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(ResetPasswordInitial());
  }

  Future<void> updatePassword() async {
    if (!formKey.currentState!.validate()) return;

    try {
      emit(ResetPasswordLoading());

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      emit(ResetPasswordSuccess('تم تغيير كلمة المرور بنجاح'));
    } catch (e) {
      emit(ResetPasswordError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
