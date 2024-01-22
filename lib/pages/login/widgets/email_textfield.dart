import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_calculator_v2_1/pages/login/login.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextField(
          style: const TextStyle(color: Colors.white),
          onChanged: (value) => context.read<LoginBloc>().add(EmailChanged(value)),
          decoration: const InputDecoration(
            labelStyle: TextStyle(color: Colors.white),
            hintStyle: TextStyle(color: Colors.white),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 2.5)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            errorStyle: TextStyle(color: Colors.yellow),
            errorBorder: OutlineInputBorder( borderSide: BorderSide(color: Colors.yellow,width: 2)),
            focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow,width: 2.5)),
            contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
            border: OutlineInputBorder(),
            labelText: 'Email',
            hintText: 'Enter email',
            prefixIcon: Icon(Icons.email_rounded, color: Colors.white70)
          )
        ); 
      }
    );
  }
}