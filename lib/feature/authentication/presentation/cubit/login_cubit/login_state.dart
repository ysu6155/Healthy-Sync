import 'package:flutter/material.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState {
  final String error;
  LoginError(this.error);
}

class LoginPasswordVisibilityToggled extends LoginState {
  final bool isVisible;
  LoginPasswordVisibilityToggled(this.isVisible);
}

class LoginRememberMeToggled extends LoginState {
  final bool isRemembered;
  LoginRememberMeToggled(this.isRemembered);
}
