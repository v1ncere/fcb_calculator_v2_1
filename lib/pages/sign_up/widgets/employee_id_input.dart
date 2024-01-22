import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_calculator_v2_1/pages/sign_up/sign_up.dart';
import 'package:fcb_calculator_v2_1/repository/repository.dart';

class EmployeeIdInput extends StatelessWidget {
  const EmployeeIdInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.employeeId != current.employeeId,
      builder: (context, state) {
        return TextField(
          onChanged: (value) => context.read<SignUpBloc>().add(EmployeeIdChanged(value)),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Employee Id',
            errorText: state.employeeId.displayError?.text()
          )
        );
      }
    );
  }
}