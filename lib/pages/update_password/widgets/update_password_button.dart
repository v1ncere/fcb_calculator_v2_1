import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:fcb_calculator_v2_1/pages/update_password/update_password.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class UpdatePasswordButton extends StatelessWidget {
  const UpdatePasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdatePasswordBloc, UpdatePasswordState>(
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: CustomColor.deepSea,
            backgroundColor: CustomColor.turbo,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20
            )
          ),
          onPressed: state.isValid
          ? () => context.read<UpdatePasswordBloc>().add(PasswordUpdateSubmitted())
          : null,
          child: state.status.isInProgress 
            ? const Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.white,
                  )
                )
              )
            : const Text('Update Password'),
        );
      }
    );
  }
}