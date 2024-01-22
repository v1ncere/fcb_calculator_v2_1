import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:fcb_calculator_v2_1/pages/sign_up/sign_up.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status || current.isValid,
      builder: (context, state) {
        return state.status.isInProgress
        ? const CircularProgressIndicator()
        : ElevatedButton(
          style: ElevatedButton.styleFrom(elevation: 0),
          onPressed: state.isValid
          ? () => context.read<SignUpBloc>().add(SignUpSubmitted())
          : null,
          child: const Text('SUBMIT')
        );
      }
    );
  }
}