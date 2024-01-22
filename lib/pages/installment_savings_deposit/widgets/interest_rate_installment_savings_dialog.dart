import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/utils/utils.dart';

class InterestRateInstallmentSavingsDialog extends StatelessWidget {
  const InterestRateInstallmentSavingsDialog({
    super.key,
    required this.period,
    required this.ratePerAnnumBeginning,
    required this.ratePerAnnumEnd,
    required this.ratePerPeriodBeginning,
    required this.ratePerPeriodEnd,
  });
  final String period;
  final String ratePerPeriodBeginning;
  final String ratePerAnnumBeginning;
  final String ratePerPeriodEnd;
  final String ratePerAnnumEnd;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Text(
                      'Answer:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey
                      )
                    ),
                    const SizedBox(width: 5),
                    text(period),
                  ]
                ),
                const SizedBox(height: 5),
                titleText('Payment at Beginning of Term'),
                Row(
                  children: [
                    labelInfo('interest rate per period:'),
                    const SizedBox(width: 5),
                    text('$ratePerPeriodBeginning%'),
                  ]
                ),
                Row(
                  children: [
                    labelInfo('interest rate per annum:'),
                    const SizedBox(width: 5),
                    text('$ratePerAnnumBeginning%'),
                  ]
                ),
                const SizedBox( height: 20),
                titleText('Payment at End of Term'),
                Row(
                  children: [
                    labelInfo('interest rate per period:'),
                    const SizedBox(width: 5),
                    text('$ratePerPeriodEnd%'),
                  ]
                ),
                Row(
                  children: [
                    labelInfo('interest rate per annum:'),
                    const SizedBox(width: 5),
                    text('$ratePerAnnumEnd%'),
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
