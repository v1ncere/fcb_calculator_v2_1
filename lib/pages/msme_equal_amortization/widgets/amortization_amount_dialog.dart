import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/utils/utils.dart';

class AmortizationAmountDialog extends StatelessWidget {
  const AmortizationAmountDialog({
    super.key,
    required this.amortization,
    required this.netProceeds,
    required this.interestPerPeriodGP
  });
  final String amortization;
  final String netProceeds;
  final String interestPerPeriodGP;

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
                        fontWeight: FontWeight.w700, 
                        color: Colors.grey
                      )
                    )
                  ]
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        labelInfo('equal amort payment:'),
                        const SizedBox(width: 5),
                        text(Currency.php + amortization.replaceAllMapped(Currency.reg, Currency.mathFunc)),
                      ],
                    ),
                    Row(
                      children: [
                        labelInfo('net proceeds:'),
                        const SizedBox(width: 5),
                        text(Currency.php + netProceeds.replaceAllMapped(Currency.reg, Currency.mathFunc)),
                      ],
                    ),
                    Row(
                      children: [
                        labelInfo('interest per period during GP:'),
                        const SizedBox(width: 5),
                        text(Currency.php + interestPerPeriodGP.replaceAllMapped(Currency.reg, Currency.mathFunc)),
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