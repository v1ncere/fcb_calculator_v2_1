import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:fcb_calculator_v2_1/app/app.dart';
import 'package:fcb_calculator_v2_1/pages/forgot_password/forgot_password.dart';
import 'package:fcb_calculator_v2_1/pages/forgot_password/widgets/widgets.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forgot Password',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16
          )
        ),
        backgroundColor: CustomColor.lime,
      ),
      backgroundColor: CustomColor.lime,
      body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(customSnackBar(
              state.message,
              FontAwesomeIcons.triangleExclamation,
              Colors.white,
              Colors.red,
            ));
          }
          if (state.status.isSuccess) {
            ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(customSnackBar(
              state.message,
              FontAwesomeIcons.circleCheck,
              Colors.white,
              Colors.green,
            ));
            context.flow<AppStatus>().update((state) => AppStatus.unauthenticated);
          }
        },
        child: LayoutBuilder(
          builder:(BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        color: CustomColor.jewel,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              EmailTextField(),
                              SizedBox(height: 15),
                              RequestButton()
                            ]
                          )
                        )
                      )
                    )
                  ]
                )
              )
            );
          }
        ),
      )
    );
  }
}