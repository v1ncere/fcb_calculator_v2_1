import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/utils/utils.dart';

class CustomIntDropdown extends StatelessWidget {
  const CustomIntDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
  });
  final int value;
  final void Function(int?)? onChanged;
  final List<DropdownMenuItem<int>>? items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        decoration: BoxDecoration(
          color: CustomColors.jewel,
          borderRadius: BorderRadius.circular(5)
        ),
        child: Theme(
          data: Theme.of(context).copyWith(canvasColor: CustomColors.jewel),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white70),
              style: const TextStyle(color: Colors.white),
              value: value,
              items: items,
              onChanged: onChanged,
            )
          )
        )
      )
    );
  }
}