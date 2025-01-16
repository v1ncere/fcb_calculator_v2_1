import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_calculator_v2_1/pages/sign_up/sign_up.dart';
import 'package:fcb_calculator_v2_1/repository/repository.dart';

class ConfirmPasswordInput extends StatelessWidget {
  const ConfirmPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextField(
          onChanged: (value) => context.read<SignUpBloc>().add(ConfirmPasswordChanged(value)),
          obscureText: state.obscureConfirmPassword,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Confirm Password',
            errorText: state.confirmPassword.displayError?.text(),
            suffixIcon: IconButton(
              color: Colors.white70, 
              icon: Icon(
              state.obscureConfirmPassword
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined, 
              color: Colors.black38),
              onPressed: () => context.read<SignUpBloc>().add(ConfirmPasswordTextObscured()),
            )
          )
        );
      }
    );
  }
}