import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_calculator_v2_1/pages/update_password/update_password.dart';

class ConfirmNewPasswordTextField extends StatelessWidget {
  const ConfirmNewPasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdatePasswordBloc, UpdatePasswordState>(
      builder: (context, state) {
        return TextField(
          obscureText: state.isConfirmNewPasswordObscure,
          style: const TextStyle(color:Colors.white),
          onChanged: (value) => context.read<UpdatePasswordBloc>().add(ConfirmNewPasswordChanged(value)),
          decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.white),
            hintStyle: const TextStyle(color: Colors.white),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 2.5
              )
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white
              )
            ),
            errorStyle: const TextStyle(color: Colors.yellow),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.yellow, width: 2
              )
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.yellow,
                width: 2.5
              )
            ),
            contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            border: const OutlineInputBorder(),
            labelText: 'Confirm New Password',
            hintText: 'Enter confirm new password',
            prefixIcon: const Icon(
              Icons.password_rounded,
              color: Colors.white70
            ),
            suffixIcon: IconButton(
              color: Colors.white70, 
              icon: Icon(
                state.isConfirmNewPasswordObscure 
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined
              ),
              onPressed: () => context.read<UpdatePasswordBloc>().add(ConfirmNewPasswordObscured()),
            )
          )
        );
      }
    );
  }
}