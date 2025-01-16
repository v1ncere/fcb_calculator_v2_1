import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/app/app.dart';
import 'package:fcb_calculator_v2_1/pages/forgot_password/forgot_password.dart';
import 'package:fcb_calculator_v2_1/pages/home/home.dart';
import 'package:fcb_calculator_v2_1/pages/login/login.dart';
import 'package:fcb_calculator_v2_1/pages/sign_up/sign_up.dart';

List<Page<dynamic>> onGeneratePages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.signup:
      return [LoginPage.page(), SignUpPage.page()];
    case AppStatus.forgotpassword:
      return [LoginPage.page(), ForgotPasswordPage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
    case AppStatus.authenticated:
      return [HomePage.page()];
  }
}