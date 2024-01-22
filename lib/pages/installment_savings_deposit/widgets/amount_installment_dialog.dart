import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/utils/utils.dart';

class AmountInstallmentDialog extends StatelessWidget {
  const AmountInstallmentDialog({
    super.key, 
    required this.payment
  });
  final String payment;

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
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey
                      )
                    )
                  ]
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    labelInfo('periodic deposit:'),
                    const SizedBox(width: 5),
                    text(Currency.php + payment.replaceAllMapped(Currency.reg, Currency.mathFunc)),               
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