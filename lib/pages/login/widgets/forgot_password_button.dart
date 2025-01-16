import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/app/app.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.flow<AppStatus>().update((state) => AppStatus.forgotpassword),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered)) {
            return Colors.blue.withOpacity(0.04);
          }
          if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
            return Colors.blue.withOpacity(0.12);
          }
          return null;
        })
      ),
      child: const Text(
        "Forgot Password",
        style: TextStyle(
          color: Colors.white
        )
      ),
    );
  }
}