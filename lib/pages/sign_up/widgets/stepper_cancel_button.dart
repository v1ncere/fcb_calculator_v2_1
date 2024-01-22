import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_calculator_v2_1/app/app.dart';
import 'package:fcb_calculator_v2_1/pages/sign_up/sign_up.dart';

class StepperCancelButton extends StatelessWidget {
  const StepperCancelButton({super.key, this.status});
  final AppStatus? status;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => status != null
      ? context.flow<AppStatus>().update((state) => status!)
      : context.read<SignUpStepperCubit>().stepCancelled(),
      child: Text(status != null ? 'CANCEL' : 'BACK')
    );
  }
}