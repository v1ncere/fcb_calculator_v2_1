import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/utils/utils.dart';

class LoanTermDialog extends StatelessWidget {
  const LoanTermDialog({
    super.key,
    required this.loanTermModes,
    required this.loanTermYears,
    required this.netProceeds,
    required this.period,
  });
  final String loanTermModes;
  final String loanTermYears;
  final String period;
  final String netProceeds;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Material(
        type: MaterialType.transparency,
        child: Card(
          margin: const EdgeInsets.only(top: 50, left: 12, right: 12),
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
                Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        labelInfo('loan term (pay mode):'),
                        const SizedBox(width: 5),
                        text(loanTermModes + period),
                      ]
                    ),
                    Row(
                      children: [
                        labelInfo('loan term (years):'),
                        const SizedBox(width: 5),
                        text(loanTermYears),
                      ]
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