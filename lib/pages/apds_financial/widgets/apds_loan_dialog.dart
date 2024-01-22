import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/utils/utils.dart';

class APDSLoanDialog extends StatelessWidget {
  const APDSLoanDialog({
    super.key,
    required this.monthlyAmortization,
    required this.loanAmount,
    required this.outstandingBalance
  });
  final String monthlyAmortization;
  final String loanAmount;
  final String outstandingBalance;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Material(
        type: MaterialType.transparency,
        child: Card(
          margin: const EdgeInsets.only(top: 50, left: 12, right: 12),
          child: Padding(
            padding:const EdgeInsets.all(15),
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
                        labelInfo('monthly amort:'),
                        const SizedBox(width: 5),
                        text(Currency.php + monthlyAmortization.replaceAllMapped(Currency.reg, Currency.mathFunc)),
                      ],
                    ),
                    Row(
                      children: [
                        labelInfo('loan amount:'),
                        const SizedBox(width: 5),
                        text(Currency.php + loanAmount.replaceAllMapped(Currency.reg, Currency.mathFunc)),
                      ],
                    ),
                    Row(
                      children: [
                        labelInfo('outstanding balance:'),
                        const SizedBox(width: 5),
                        text(Currency.php + outstandingBalance.replaceAllMapped(Currency.reg, Currency.mathFunc)),
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