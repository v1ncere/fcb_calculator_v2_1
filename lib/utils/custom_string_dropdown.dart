import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/utils/utils.dart';

class CustomStringDropdown extends StatelessWidget {
  const CustomStringDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items
  });
  final String? value;
  final void Function(String?)? onChanged;
  final List<DropdownMenuItem<String>>? items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
        padding: const EdgeInsets.only(left: 8, right: 8),
        decoration: BoxDecoration(
          color: CustomColors.jewel,
          borderRadius:BorderRadius.circular(5)
        ),
        child:  Theme(
          data: Theme.of(context).copyWith(canvasColor: CustomColors.jewel),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white70),
              style: const TextStyle(color: Colors.white),
              items: items,
              onChanged: onChanged,
            )
          )
        )
      )
    );
  }
}