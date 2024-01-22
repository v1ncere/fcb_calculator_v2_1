import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_calculator_v2_1/pages/sign_up/sign_up.dart';

class StepperNextButton extends StatelessWidget {
  const StepperNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(elevation: 0),
      onPressed: () => context.read<SignUpStepperCubit>().stepContinued(),
      child: const Text('NEXT')
    );
  }
}