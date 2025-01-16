import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/utils/utils.dart';

class TitleTexts extends StatelessWidget {
  const TitleTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 12),
      child: Row(
        children: [
          Text(
            'FCB',
            style: TextStyle(
              color: CustomColor.jewel,
              fontSize: 28,
              fontWeight: FontWeight.bold
            )
          ),
          const SizedBox(width: 5),
          const Text(
            'e',
            style: TextStyle(
              color: Colors.lightBlue,
              fontSize: 28,
              fontWeight: FontWeight.bold
            )
          ),
          Text(
            'Calculator',
            style: TextStyle(
              color: Colors.lightGreenAccent[700],
              fontSize: 28,
              fontWeight: FontWeight.bold
            )
          ),
          Icon(
            Icons.calculate_rounded,
            size: 34,
            color: CustomColor.jewel
          )
        ]
      )
    );
  }
}