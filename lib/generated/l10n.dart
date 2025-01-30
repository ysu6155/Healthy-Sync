// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Please sign up to get started`
  String get pleaseSignUpToGetStarted {
    return Intl.message(
      'Please sign up to get started',
      name: 'pleaseSignUpToGetStarted',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Retype Password`
  String get retypePassword {
    return Intl.message(
      'Retype Password',
      name: 'retypePassword',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Stable`
  String get stable {
    return Intl.message(
      'Stable',
      name: 'stable',
      desc: '',
      args: [],
    );
  }

  /// `Special`
  String get special {
    return Intl.message(
      'Special',
      name: 'special',
      desc: '',
      args: [],
    );
  }

  /// `Doctors`
  String get doctor {
    return Intl.message(
      'Doctors',
      name: 'doctor',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get seeAll {
    return Intl.message(
      'See All',
      name: 'seeAll',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Healthy Sync`
  String get welcomeToHealthySync {
    return Intl.message(
      'Welcome to Healthy Sync',
      name: 'welcomeToHealthySync',
      desc: '',
      args: [],
    );
  }

  /// `Empowering you to live a healthier life`
  String get Empoweringyoutoliveahealthierlife {
    return Intl.message(
      'Empowering you to live a healthier life',
      name: 'Empoweringyoutoliveahealthierlife',
      desc: '',
      args: [],
    );
  }

  /// `Empowering`
  String get Empowering {
    return Intl.message(
      'Empowering',
      name: 'Empowering',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Easy to use`
  String get easyToUse {
    return Intl.message(
      'Easy to use',
      name: 'easyToUse',
      desc: '',
      args: [],
    );
  }

  /// `Easy to use and simple`
  String get easyToUseAndSimple {
    return Intl.message(
      'Easy to use and simple',
      name: 'easyToUseAndSimple',
      desc: '',
      args: [],
    );
  }

  /// `Start Now`
  String get startNow {
    return Intl.message(
      'Start Now',
      name: 'startNow',
      desc: '',
      args: [],
    );
  }

  /// `Join Now`
  String get joinNow {
    return Intl.message(
      'Join Now',
      name: 'joinNow',
      desc: '',
      args: [],
    );
  }

  /// `Ready to start your sync`
  String get readyToStartYourSync {
    return Intl.message(
      'Ready to start your sync',
      name: 'readyToStartYourSync',
      desc: '',
      args: [],
    );
  }

  /// `Email/Phone`
  String get emailPhone {
    return Intl.message(
      'Email/Phone',
      name: 'emailPhone',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password `
  String get forgotPassword {
    return Intl.message(
      'Forgot Password ',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Remember Me`
  String get rememberMe {
    return Intl.message(
      'Remember Me',
      name: 'rememberMe',
      desc: '',
      args: [],
    );
  }

  /// `don't Have An Account ?`
  String get dontHaveAnAccount {
    return Intl.message(
      'don\'t Have An Account ?',
      name: 'dontHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Select An Gender`
  String get gender {
    return Intl.message(
      'Select An Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Select A City`
  String get selectACity {
    return Intl.message(
      'Select A City',
      name: 'selectACity',
      desc: '',
      args: [],
    );
  }

  /// `Create a new account`
  String get createAccount {
    return Intl.message(
      'Create a new account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `I agree to Terms and Conditions`
  String get iAgreeToTermsAndConditions {
    return Intl.message(
      'I agree to Terms and Conditions',
      name: 'iAgreeToTermsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `already have an account ?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'already have an account ?',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email or phone`
  String get enterYourEmailOrPhone {
    return Intl.message(
      'Enter your email or phone',
      name: 'enterYourEmailOrPhone',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone`
  String get enterYourPhone {
    return Intl.message(
      'Enter your phone',
      name: 'enterYourPhone',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get enterYourEmail {
    return Intl.message(
      'Enter your email',
      name: 'enterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Send Code`
  String get sendCode {
    return Intl.message(
      'Send Code',
      name: 'sendCode',
      desc: '',
      args: [],
    );
  }

  /// `Verification`
  String get verification {
    return Intl.message(
      'Verification',
      name: 'verification',
      desc: '',
      args: [],
    );
  }

  /// `Code sent to `
  String get CodeSentTo {
    return Intl.message(
      'Code sent to ',
      name: 'CodeSentTo',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get Code {
    return Intl.message(
      'Code',
      name: 'Code',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code sent to`
  String get enterTheCode {
    return Intl.message(
      'Enter the code sent to',
      name: 'enterTheCode',
      desc: '',
      args: [],
    );
  }

  /// `Code is required`
  String get codeIsRequired {
    return Intl.message(
      'Code is required',
      name: 'codeIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get emailIsRequired {
    return Intl.message(
      'Email is required',
      name: 'emailIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordIsRequired {
    return Intl.message(
      'Password is required',
      name: 'passwordIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Age is required`
  String get ageIsRequired {
    return Intl.message(
      'Age is required',
      name: 'ageIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Name Is required`
  String get nameIsRequired {
    return Intl.message(
      'Name Is required',
      name: 'nameIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Phone Is required`
  String get phoneIsRequired {
    return Intl.message(
      'Phone Is required',
      name: 'phoneIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Gender Is required`
  String get genderIsRequired {
    return Intl.message(
      'Gender Is required',
      name: 'genderIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password is required`
  String get confirmPasswordIsRequired {
    return Intl.message(
      'Confirm Password is required',
      name: 'confirmPasswordIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Login To Your Account`
  String get loginToYourAccount {
    return Intl.message(
      'Login To Your Account',
      name: 'loginToYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Not Stable`
  String get notStable {
    return Intl.message(
      'Not Stable',
      name: 'notStable',
      desc: '',
      args: [],
    );
  }

  /// `specializations`
  String get specializations {
    return Intl.message(
      'specializations',
      name: 'specializations',
      desc: '',
      args: [],
    );
  }

  /// `specialization`
  String get specialization {
    return Intl.message(
      'specialization',
      name: 'specialization',
      desc: '',
      args: [],
    );
  }

  /// `About Doctor`
  String get AboutDoctor {
    return Intl.message(
      'About Doctor',
      name: 'AboutDoctor',
      desc: '',
      args: [],
    );
  }

  /// `No additional information provided`
  String get NoAdditionalInformationProvided {
    return Intl.message(
      'No additional information provided',
      name: 'NoAdditionalInformationProvided',
      desc: '',
      args: [],
    );
  }

  /// `callDoctor`
  String get callDoctor {
    return Intl.message(
      'callDoctor',
      name: 'callDoctor',
      desc: '',
      args: [],
    );
  }

  /// `Chat With Doctor`
  String get chatWithDoctor {
    return Intl.message(
      'Chat With Doctor',
      name: 'chatWithDoctor',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message(
      'Resend',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get rating {
    return Intl.message(
      'Rating',
      name: 'rating',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid number`
  String get PleaseEnterAValidNumber {
    return Intl.message(
      'Please enter a valid number',
      name: 'PleaseEnterAValidNumber',
      desc: '',
      args: [],
    );
  }

  /// `Password does not match`
  String get PasswordDoesNotMatch {
    return Intl.message(
      'Password does not match',
      name: 'PasswordDoesNotMatch',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
