import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:fcb_calculator_v2_1/pages/forgot_password/forgot_password.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class RequestButton extends StatelessWidget {
  const RequestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.status != current.status || current.isValid,
      builder: (context, state) {
        return state.status.isInProgress
        ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                )
              )
            )
          )
        : SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: CustomColor.deepSea,
              backgroundColor: CustomColor.turbo,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              )
            ),
            onPressed: state.isValid
            ? () => context.read<ForgotPasswordBloc>().add(RequestSubmitted())
            : null,
            child: const Text('Request Reset'),
          )
        );
      }
    );
  }
}