import 'package:fcb_calculator_v2_1/app/app.dart';
import 'package:fcb_calculator_v2_1/pages/sign_up/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SignUpAccountsView extends StatelessWidget {
  const SignUpAccountsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 5.0),
        EmailInput(),
        SizedBox(height: 12.0),
        PasswordInput(),
        SizedBox(height: 12.0),
        ConfirmPasswordInput(),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            StepperCancelButton(status: AppStatus.unauthenticated),
            SizedBox(width: 10),
            StepperNextButton()
          ]
        )
      ]
    );
  }
}