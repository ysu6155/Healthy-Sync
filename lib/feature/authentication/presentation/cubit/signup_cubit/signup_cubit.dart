import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:healthy_sync/core/service/local/shared_keys.dart';
import 'package:healthy_sync/core/service/local/shared_helper.dart';
import 'package:healthy_sync/feature/authentication/data/models/request/register_params.dart';
import 'package:healthy_sync/feature/authentication/data/repo/auth_repo.dart';

import 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  final List<String> cities = [
    'Cairo',
    'Alexandria',
    'Giza',
    'Sharm El Sheikh',
    'Hurghada',
    'Luxor',
    'Aswan',
    'Port Said',
    'Suez',
    'Tanta',
    'Mansoura',
    'Damanhur',
    'Ismailia',
    'Minya',
    'Beni Suef',
    'Fayoum',
    'Qena',
    'Sohag',
  ];

  String? selectedGender;
  String? selectedCity;
  bool isPasswordVisible = false;
  bool isAgreedToTerms = false;
  String? selectedAccountType;

  void selectAccountType(String? accountType) {
    selectedAccountType = accountType;
    emit(AccountTypeSelected(selectedAccountType));
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordVisibilityToggled(isPasswordVisible));
  }

  void selectGender(String? gender) {
    selectedGender = gender;
    emit(GenderSelected(selectedGender));
  }

  void selectCity(String? city) {
    selectedCity = city;
    emit(CitySelected(selectedCity));
  }

  void toggleTermsAgreement(bool value) {
    isAgreedToTerms = value;
    emit(TermsAgreementToggled(isAgreedToTerms));
  }


  Future<void> register(RegisterParams params) async {
    if (!formKey.currentState!.validate()) return;

    if (!isAgreedToTerms) {
      emit(SignUpError("localeKeys.agreeToTermsError.tr()"));
      return;
    }

    emit(SignUpLoading());

    try {
      final result = await AuthRepo.register(params); 

      SharedHelper.sava(SharedKeys.kToken, result.token);
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpError(e.toString())); 
    }
  }
}
