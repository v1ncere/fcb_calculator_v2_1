import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/pages/time_deposit/widgets/widgets.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class TermYearsTab extends StatefulWidget {
  const TermYearsTab({super.key});

  @override
  State<TermYearsTab> createState() => _TermYearsTabState();
}

class _TermYearsTabState extends State<TermYearsTab> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _timePresentValueTF = TextEditingController();
  final TextEditingController _timeAnnualInterestRateTF = TextEditingController();
  final TextEditingController _timeFutureValueTF = TextEditingController();
  
  String _timeYears = '';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // TOP BG IMAGE
        backgroundImage(30.0, -20.0, null, null, 300.0, 300.0, 15.0 / 360.0),
        // BOTTON BG IMAGE
        backgroundImage(null, null, 45.0, -20.0, 200.0, 200.0, -15.0 / 360.0),
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
                        // PRINCIPAL AMOUNT TEXTFIELD
                        textfieldThousandsSeparator(
                          'Principal',
                          'Enter principal amount',
                          Text(Currency.php),
                          _timePresentValueTF
                        ),
                        // INTEREST RATE TEXTFIELD
                        textfield(
                          'Annual Interest Rate',
                          'Enter annual interest rate',
                          const Text('%'),
                          _timeAnnualInterestRateTF
                        ),
                        // FUTURE VALUE TEXTFIELD
                        textfieldThousandsSeparator(
                          'Future Value',
                          'Enter future value amount',
                          Text(Currency.php),
                          _timeFutureValueTF
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
                                    double P = double.parse(_timePresentValueTF.text.replaceAll(',', ''));
                                    double r = double.parse(_timeAnnualInterestRateTF.text)/100;
                                    double F = double.parse(_timeFutureValueTF.text.replaceAll(',', ''));

                                    _timeYears = ((1/r)*((F/P)-1)).toStringAsFixed(2);
                                    // SHOW RESULT DIALOG
                                    showGeneralDialog(
                                      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                      barrierDismissible: true,
                                      barrierColor:Colors.black.withOpacity(0.5),
                                      transitionDuration:const Duration(milliseconds: 300),
                                      context: context,
                                      pageBuilder: (_, __, ___) {
                                        return TermYearsDialog(timeYears: _timeYears);
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
                                  _timePresentValueTF.clear();
                                  _timeAnnualInterestRateTF.clear();
                                  _timeFutureValueTF.clear();
                                });
                              }
                            )
                          )
                        ),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.all(3),
                          width: MediaQuery.of(context).size.width,
                          child: Text('Example: How many years are required to increase a principal amount of P500 to a total of P710.00 at an annual interest rate of 6.0%? (Ans: 7.00 yrs.)',
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