import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_calculator_v2_1/pages/sign_up/sign_up.dart';
import 'package:fcb_calculator_v2_1/repository/repository.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class MobileNumberInput extends StatelessWidget {
  const MobileNumberInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.mobileNumber != current.mobileNumber,
      builder: (context, state) {
        return TextField(
          inputFormatters: [PhoneNumberFormatter()],
          onChanged: (value) => context.read<SignUpBloc>().add(MobileNumberChanged(value)),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Mobile number',
            hintText: '+639XXXXXXXXX',
            errorText: state.mobileNumber.displayError?.text()
          )
        );
      }
    );
  }
}