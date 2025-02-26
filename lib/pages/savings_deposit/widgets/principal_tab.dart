import 'dart:math';

import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/pages/savings_deposit/widgets/widgets.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class PrincipalTab extends StatefulWidget {
  const PrincipalTab({super.key});

  @override
  State<PrincipalTab> createState() => _PrincipalTabState();
}

class _PrincipalTabState extends State<PrincipalTab> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _savingsAnnualInterestRateTF = TextEditingController();
  final TextEditingController _savingsFutureValueTF = TextEditingController();
  final TextEditingController _savingsYearsTF = TextEditingController();
  
  int _compounding = 12;
  String _savingsPresentValue = '';

  @override
  void dispose() {
    _savingsAnnualInterestRateTF.dispose();
    _savingsFutureValueTF.dispose();
    _savingsYearsTF.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // TOP BG IMAGE
        backgroundImage(null, 0.0, 20.0, null, 300.0, 300.0, 15.0 / 360.0),
        // BOTTOM BG IMAGE
        backgroundImage(30.0, null, null, 0.0, 200.0, 200.0, -15.0 / 360.0),
        // USER INPUT
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
                            style: TextStyle(
                              color: Colors.lightGreen[700]
                            )
                          )
                        ),
                        // COMPOUNDING DROPDOWN BUTTON
                        CustomIntDropdown(
                          value: _compounding,
                          items: const [
                            DropdownMenuItem(value: 12,child: Text("Monthly")),
                            DropdownMenuItem(value: 4,child: Text("Quarterly")),
                            DropdownMenuItem(value: 2,child: Text("Semi-Annually")),
                            DropdownMenuItem(value: 1,child: Text("Annually")),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _compounding = value!;
                            });
                          },
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
                          'Future value',
                          'Enter future value',
                          Text(Currency.php),
                          _savingsFutureValueTF
                        ),
                        // TERM, YEARS TEXTFIELD
                        textfield(
                          'Term/Years',
                          'Enter term/years',
                          const Text('yr.'),
                          _savingsYearsTF
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
                                backgroundColor: CustomColor.jewel,
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
                                    double r = double.parse(_savingsAnnualInterestRateTF.text) / 100.0;
                                    double F = double.parse(_savingsFutureValueTF.text.replaceAll(',', ''));
                                    double n = double.parse(_savingsYearsTF.text);

                                    double rate = r/_compounding;
                                    double period = n*_compounding;

                                    _savingsPresentValue = (F/pow(1+rate, period)).toStringAsFixed(2);
                                    // SHOW RESULT DIALOG
                                    showGeneralDialog(
                                      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                      barrierDismissible: true,
                                      barrierColor:Colors.black.withOpacity(0.5),
                                      transitionDuration:const Duration(milliseconds: 300),
                                      context: context,
                                      pageBuilder: (_,__,___) {
                                        return PrincipalDialog(savingsPresentValue: _savingsPresentValue);
                                      },
                                      transitionBuilder:(_,anim,__,child) {
                                        return SlideTransition(
                                          position: Tween(
                                            begin: const Offset(0, -1),
                                            end: const Offset(0, 0)
                                          ).animate(anim),
                                          child: child,
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
                                  _savingsAnnualInterestRateTF.clear();
                                  _savingsFutureValueTF.clear();
                                  _savingsYearsTF.clear();
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
                          child: Text('Example: You are to bring the total amount of savings to P20,000.00 in 10 years. Your annual interest rate is 5.50%, compounded quarterly. How much principal must be invested to reach your goal? (Ans: P11,582.31)',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.lightGreen[700],
                              fontSize: 16
                            )
                          )
                        ),
                        const SizedBox(height: 15),
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
