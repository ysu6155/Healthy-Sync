import 'dart:developer';

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
  final TextEditingController diseaseController = TextEditingController();

  Map<String, List<String>> chronicDiseasesByLanguage = {
    'ar': [
      "السكري",
      "ارتفاع ضغط الدم",
      "أمراض القلب",
      "الربو",
      "التهاب المفاصل",
      "أمراض الكبد المزمنة",
      "أمراض الكلى المزمنة",
      "مرض الانسداد الرئوي المزمن",
      "الصرع",
      "هشاشة العظام",
      "أمراض الغدة الدرقية",
      "مرض باركنسون",
      "الصدفية",
      "التصلب المتعدد",
      "السمنة المفرطة",
      "أمراض الجهاز الهضمي المزمنة",
    ],
    'en': [
      "Diabetes",
      "High blood pressure",
      "Heart disease",
      "Asthma",
      "Arthritis",
      "Chronic liver disease",
      "Chronic kidney disease",
      "Chronic obstructive pulmonary disease (COPD)",
      "Epilepsy",
      "Osteoporosis",
      "Thyroid disorders",
      "Parkinson's disease",
      "Psoriasis",
      "Multiple sclerosis",
      "Obesity",
      "Chronic digestive diseases",
    ],
  };

  List<String> getChronicDiseases(String langCode) {
    return chronicDiseasesByLanguage[langCode] ??
        chronicDiseasesByLanguage['en']!;
  }

  String? selectedSpecialization;

  void selectSpecialization(String? specialization) {
    selectedSpecialization = specialization;
    emit(SpecializationSelected(specialization));
  }

  List<String> getSpecializations() {
    return [
      "Cardiology", // قلب
      "Dermatology", // جلدية
      "Neurology", // مخ وأعصاب
      "Orthopedics", // عظام
      "Pediatrics", // أطفال
      "Psychiatry", // نفسية
      "Radiology", // أشعة
      "Surgery", // جراحة
    ];
  }

  List<String> selectedDiseases = [];
  Map<String, List<String>> citiesByLanguage = {
    'ar': [
      'القاهرة',
      'الإسكندرية',
      'الجيزة',
      'شرم الشيخ',
      'الغردقة',
      'الأقصر',
      'أسوان',
      'بورسعيد',
      'السويس',
      'طنطا',
      'المنصورة',
      'دمنهور',
      'الإسماعيلية',
      'المنيا',
      'بني سويف',
      'الفيوم',
      'قنا',
      'سوهاج',
    ],
    'en': [
      'Cairo',
      'Alexandria',
      'Giza',
      'Sharm El-Sheikh',
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
    ],
  };

  List<String> getCities(String langCode) {
    return citiesByLanguage[langCode] ?? citiesByLanguage['ar']!;
  }

  String? selectedGender;
  String? selectedCity;
  bool isPasswordVisible = false;
  bool isAgreedToTerms = false;

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
      SharedHelper.sava(SharedKeys.id, result.data?.newUser?.id);
      SharedHelper.sava(SharedKeys.role, result.data?.newUser?.role);
      SharedHelper.sava(SharedKeys.name, result.data?.newUser?.name);
      SharedHelper.sava(SharedKeys.email, result.data?.newUser?.email);
      SharedHelper.sava(SharedKeys.gender, result.data?.newUser?.gender);
      SharedHelper.sava(
          SharedKeys.dateOfBirth, result.data?.newUser?.dateOfBirth);

      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpError(e.toString()));
      log(e.toString());
    }
  }
}
