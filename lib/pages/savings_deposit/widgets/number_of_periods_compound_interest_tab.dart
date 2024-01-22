import 'dart:math';

import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/pages/savings_deposit/widgets/widgets.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class NumberPeriodsCompoundInterestTab extends StatefulWidget {
  const NumberPeriodsCompoundInterestTab({super.key});

  @override
  State<NumberPeriodsCompoundInterestTab> createState() => _NumberPeriodsCompoundInterestTabState();
}

class _NumberPeriodsCompoundInterestTabState extends State<NumberPeriodsCompoundInterestTab> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _savingsPresentValueTF = TextEditingController();
  final TextEditingController _savingsAnnualInterestRateTF = TextEditingController();
  final TextEditingController _savingsFutureValueTF = TextEditingController();
  int _compounding = 12;
  String _savingsYears = '';

  @override
  void dispose() {
    _savingsPresentValueTF.dispose();
    _savingsAnnualInterestRateTF.dispose();
    _savingsFutureValueTF.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // TOP BG IMAGE
        backgroundImage(30.0, -20.0, null, null, 300.0, 300.0, 15.0 / 360.0),
        // BOTTOM BG IMAGE
        backgroundImage(null, null, 45.0, -20.0, 200.0, 200.0, 15.0 / 360.0),
        // USER INPUT LAYOUT
        LayoutBuilder(
          builder:(BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            'Compounding',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.lightGreen[700])
                          )
                        ),
                        // COMPOUNDING DROPDOWN BUTTON
                        CustomIntDropdown(
                          value: _compounding,
                          items: const [
                            DropdownMenuItem(value: 12, child: Text("Monthly")),
                            DropdownMenuItem(value: 4, child: Text("Quarterly")),
                            DropdownMenuItem(value: 2, child: Text("Semi-Annually")),
                            DropdownMenuItem(value: 1, child: Text("Annually")),
                          ],
                          onChanged: (value) {
                            setState(() { _compounding = value!; });
                          }
                        ),
                        // PRINCIPAL AMOUNT TEXTFIELD
                        textfieldThousandsSeparator(
                          'Principal', 'Enter principal amount',
                          Text(Currency.php),
                          _savingsPresentValueTF
                        ),
                        // INTEREST RATE TEXTFIELD
                        textfield(
                          'Annual Interest Rate',
                          'Enter annual interest rate',
                          const Text('%'),
                          _savingsAnnualInterestRateTF
                        ),
                        // FUTURE VALUE TEXTFIELD
                        textfieldThousandsSeparator(
                          'Future Value',
                          'Enter future value',
                          Text(Currency.php),
                          _savingsFutureValueTF
                        ),
                        // HORIZONTAL LINE
                        line,
                        // CALCULATE BUTTON
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColors.jewel,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8))
                                )
                              ),
                              child: const Text(
                                'CALCULATE',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white
                                )
                              ),
                              onPressed: () {
                                setState(() {
                                  if (_formKey.currentState!.validate()) {
                                    double P = double.parse(_savingsPresentValueTF.text.replaceAll(',', ''));
                                    double r = double.parse(_savingsAnnualInterestRateTF.text) / 100;
                                    double F = double.parse(_savingsFutureValueTF.text.replaceAll(',', ''));

                                    double rate = r/_compounding;

                                    _savingsYears = (log(F/P)/(_compounding*log(1+rate))).toStringAsFixed(2);

                                    // SHOW RESULT DIALOG
                                    showGeneralDialog(
                                      barrierLabel:MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                      barrierDismissible: true,
                                      barrierColor:Colors.black.withOpacity(0.5),
                                      transitionDuration: const Duration(milliseconds: 300),
                                      context: context,
                                      pageBuilder: (_, __, ___) {
                                        return NumberPeriodsCompoundInterestDialog(savingsYears: _savingsYears);
                                      },
                                      transitionBuilder:(_, anim, __, child) {
                                        return SlideTransition(
                                          position: Tween(
                                            begin: const Offset(0, -1),
                                            end: const Offset(0, 0)
                                          ).animate(anim),
                                          child: child
                                        );
                                      }
                                    );
                                  } else {
                                    showToast("Complete all the fields.");
                                  }
                                });
                              }
                            )
                          )
                        ),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8))
                                )
                              ),
                              child: const Text(
                                'CLEAR',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white
                                )
                              ),
                              onPressed: () {
                                setState(() {
                                  _formKey.currentState?.reset();
                                  _savingsPresentValueTF.clear();
                                  _savingsAnnualInterestRateTF.clear();
                                  _savingsFutureValueTF.clear();
                                  _compounding = 12;
                                });
                              }
                            )
                          )
                        ),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.all(3),
                          width: MediaQuery.of(context).size.width,
                          child: Text('Example: How many years are required to increase a principal amount of P5,000 to a total of P10,000 at an annual interest rate of 5.4%, compounded annually? (Ans: 13.18 years)',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.lightGreen[700],
                              fontSize: 16
                            )
                          )
                        ),
                        const SizedBox(height: 10),
                      ]
                    )
                  )
                )
              )
            );
          }
        )
      ]
    );
  }
}
