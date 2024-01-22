import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_calculator_v2_1/pages/sign_up/sign_up.dart';
import 'package:fcb_calculator_v2_1/repository/repository.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextField(
          onChanged: (value) => context.read<SignUpBloc>().add(PasswordChanged(value)),
          obscureText: state.obscurePassword,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Password',
            errorText: state.password.displayError?.text(),
            suffixIcon: IconButton(
              color: Colors.white70, 
              icon: Icon(
              state.obscurePassword 
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined),
              onPressed: () => context.read<SignUpBloc>().add(PasswordTextObscured()),
            )
          )
        );
      }
    );
  }
}