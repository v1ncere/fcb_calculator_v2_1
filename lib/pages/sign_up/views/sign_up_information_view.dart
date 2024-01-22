import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:fcb_calculator_v2_1/app/app.dart';
import 'package:fcb_calculator_v2_1/pages/sign_up/sign_up.dart';
import 'package:fcb_calculator_v2_1/pages/sign_up/widgets/widgets.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class SignUpInformationView extends StatelessWidget {
  const SignUpInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if(state.status.isSuccess) {
          context.flow<AppStatus>().update((next) => AppStatus.unauthenticated);
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(
            "Registration account successful! We've sent a verification link to your email.",
            FontAwesomeIcons.solidCircleCheck,
            Colors.white
          ));
        }
        if(state.status.isFailure) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(
            state.message,
            FontAwesomeIcons.triangleExclamation,
            Colors.red
          ));
        }
      },
      child: const Column(
        children: [
          SizedBox(height: 5.0),
          MobileNumberInput(),
          SizedBox(height: 12.0),
          EmployeeIdInput(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              StepperCancelButton(),
              SizedBox(width: 10),
              SubmitButton()
            ]
          )          
        ]
      )
    );
  }
}