import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:healthy_sync/feature/layout/presentation/screens/layout/layout_screen.dart';
import 'package:healthy_sync/core/utils/extensions.dart';
import 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
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
    'Sohag'
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

  void signUp(BuildContext context) {
    if (!formKey.currentState!.validate()) return;
    if (!isAgreedToTerms) {
      emit(SignUpError("يجب الموافقة على الشروط والأحكام"));
      return;
    }
    emit(SignUpLoading());

    // محاكاة API Call
    Future.delayed(Duration(seconds: 2), () {
      context.pushAndRemoveUntil(TapBarScreen());
      emit(SignUpSuccess());
    });
  }
}
