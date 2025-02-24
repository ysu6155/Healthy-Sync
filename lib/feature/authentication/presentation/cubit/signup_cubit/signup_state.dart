import 'package:flutter/material.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpError extends SignUpState {
  final String error;
  SignUpError(this.error);
}

class PasswordVisibilityToggled extends SignUpState {
  final bool isPasswordVisible;
  PasswordVisibilityToggled(this.isPasswordVisible);
}

class GenderSelected extends SignUpState {
  final String? selectedGender;
  GenderSelected(this.selectedGender);
}
class CitySelected extends SignUpState {
  final String? selectedCity;
  CitySelected(this.selectedCity);
}


class TermsAgreementToggled extends SignUpState {
  final bool isAgreed;
  TermsAgreementToggled(this.isAgreed);
}
class AccountTypeSelected extends SignUpState {
  final String? selectedAccountType;
  AccountTypeSelected(this.selectedAccountType);
}
