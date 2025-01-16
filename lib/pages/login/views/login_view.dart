import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:fcb_calculator_v2_1/pages/login/login.dart';
import 'package:fcb_calculator_v2_1/pages/login/widgets/widgets.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.lime,
      body: BlocListener<LoginBloc, LoginState>(
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
        },
        child: Stack(
          children: [
            /// TOP BG IMAGE
            backgroundImage(null, 50.0, null, null, 300.0, 300.0, 15.0 / 360.0),
            /// BOTTOM BG IMAGE
            backgroundImage(null, null, 20.0, 40.0, 150.0, 150.0, 15.0 / 360.0),
            // BACKGROUND LAYOUT
            LayoutBuilder(
              builder:(BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:BoxConstraints(minHeight: viewportConstraints.maxHeight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 5,
                            color: CustomColor.jewel,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)
                            ),
                            child: SizedBox(
                              height: 350,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // FCB CALCULATOR TITLE
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text("FCB", style: TextStyle(
                                          color:Colors.white,
                                          fontFamily: 'San-Serif',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30
                                        )),
                                        const SizedBox(width: 5),
                                        const Text("e", style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontFamily: 'San-Serif',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30
                                        )),
                                        Text("Calculator", style: TextStyle(
                                          color:Colors.lightGreenAccent[700],
                                          fontFamily: 'San-Serif',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30
                                        ))
                                      ]
                                    ),
                                    // USER ID TEXTFIELD
                                    const EmailTextField(),
                                    // _password TEXTFIELD
                                    const PasswordTextField(),
                                    const SizedBox(height: 5),
                                    // LOGIN BUTTON
                                    const LoginButton(),
                                    // REGISTER FLATBUTTON
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        ForgotPasswordButton(),
                                        SignUpButton(),
                                      ],
                                    )
                                  ]
                                )
                              )
                            )
                          )
                        )
                      ]
                    )
                  )
                );
              }
            )
          ]
        ),
      )
    );
  }
}