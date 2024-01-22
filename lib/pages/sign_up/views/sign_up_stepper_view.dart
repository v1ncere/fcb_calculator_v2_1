import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_calculator_v2_1/pages/sign_up/sign_up.dart';

class SignUpStepperView extends StatelessWidget {
  const SignUpStepperView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpStepperCubit, int>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w700
                )
              )
            ),
            body: BlocBuilder<SignUpBloc, SignUpState>(
              builder: (context, newState) {
                return Stepper(
                  type: StepperType.vertical,
                  elevation: 0,
                  physics: const NeverScrollableScrollPhysics(),
                  currentStep: state,
                  onStepTapped: context.read<SignUpStepperCubit>().stepTapped,
                  controlsBuilder: (context, details) => const SizedBox.shrink(),
                  steps: pageSteps(state, newState),
                );
              }
            )
          )
        );
      }
    );
  }

  List<Step> pageSteps(int current, SignUpState signUpState) {
    StepState getStepState(int stepIndex) {
      if (current < stepIndex) {
        return StepState.disabled;
      } else if (current == stepIndex) {
        if (signUpState.isPure) {
          return StepState.indexed;
        } 
        if (signUpState.isDirty) {
          return StepState.editing;
        }
        else {
          return StepState.error;
        }
      } else {
        if (signUpState.email.isNotValid ||
            signUpState.password.isNotValid ||
            signUpState.confirmPassword.isNotValid) {
          return StepState.error;
        } else {
          return StepState.complete;
        }
      }
    }

    return <Step> [
      Step(
        title: const Text('Email & Password'),
        content: const SignUpAccountsView(),
        isActive: current >= 0,
        state: getStepState(0)
      ),
      Step(
        title: const Text('Additional Info'),
        content: const SignUpInformationView(),
        isActive: current >= 1,
        state: getStepState(1)
      )
    ];
  }
}