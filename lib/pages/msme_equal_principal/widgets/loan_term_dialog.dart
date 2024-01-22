import 'package:flutter/material.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class LoanTermDialog extends StatelessWidget {
  const LoanTermDialog({
    super.key,
    required this.loanTerm,
    required this.firstAmort,
    required this.lastAmort,
    required this.netProceeds,
    required this.interestPerPeriodGP
  });
  final String loanTerm;
  final String firstAmort;
  final String lastAmort;
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
                        fontWeight:FontWeight.w700,
                        color: Colors.grey
                      )
                    )
                  ]
                ),
                const SizedBox(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        labelInfo('loan term (years):'),
                        const SizedBox(width: 5),
                        text(loanTerm.replaceAllMapped(Currency.reg, Currency.mathFunc)),
                      ]
                    ),
                    Row(
                      children: [
                        labelInfo('first amort payment:'),
                        const SizedBox(width: 5),
                        text(Currency.php + firstAmort.replaceAllMapped(Currency.reg, Currency.mathFunc)),
                      ]
                    ),
                    Row(
                      children: [
                        labelInfo('last amort payment:'),
                        const SizedBox(width: 5),
                        text(Currency.php + lastAmort.replaceAllMapped(Currency.reg, Currency.mathFunc)),
                      ]
                    ),
                    Row(
                      children: [
                        labelInfo('net proceeds:'),
                        const SizedBox(width: 5),
                        text(Currency.php + netProceeds.replaceAllMapped(Currency.reg, Currency.mathFunc)),
                      ]
                    ),
                    Row(
                      children: [
                        labelInfo('interest per period during GP:'),
                        const SizedBox(width: 5),
                        text(Currency.php + interestPerPeriodGP.replaceAllMapped(Currency.reg, Currency.mathFunc)),
                      ]
                    ),
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