import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/utils/utils.dart';

class AmortizationDialog extends StatelessWidget {
  const AmortizationDialog({
    super.key,
    required this.loanAmount,
    required this.netProceeds
  });
  final String loanAmount;
  final String netProceeds;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Material(
        type: MaterialType.transparency,
        child: Card(
          margin: const EdgeInsets.only(top: 50,left: 12,right: 12),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  children: [
                    Text(
                      'Answer:',
                      style: TextStyle(
                        fontSize:20,
                        fontWeight:FontWeight.w700,
                        color: Colors.grey,
                      )
                    )
                  ]
                ),
                const SizedBox(height: 5),
                Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        labelInfo('loan amount:'),
                        const SizedBox(width: 5),
                        text(Currency.php + loanAmount.replaceAllMapped(Currency.reg, Currency.mathFunc)),
                      ],
                    ),
                    Row(
                      children: [
                        labelInfo('net proceeds:'),
                        const SizedBox(width: 5),
                        text(Currency.php + netProceeds.replaceAllMapped(Currency.reg, Currency.mathFunc)),
                      ]
                    )
                  ]
                )
              ]
            )
          )
        )
      )
    );
  }
}
