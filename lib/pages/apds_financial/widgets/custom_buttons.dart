import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/utils/utils.dart';

class CustomButtons extends StatelessWidget {
  const CustomButtons({
    super.key,
    required this.onPressed,
    required this.title
  });
  final void Function()? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: CustomColors.jewel,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))
            )
          ),
          onPressed: onPressed,
          child: Text(
            title,
            style: const TextStyle(fontSize: 16)
          )
        )
      )
    );
  }
}