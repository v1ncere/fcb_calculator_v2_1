import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/pages/time_deposit/widgets/widgets.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class InterestRateTab extends StatefulWidget {
  const InterestRateTab({super.key});

  @override
  State<InterestRateTab> createState() => _InterestRateTabState();
}

class _InterestRateTabState extends State<InterestRateTab> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _timePresentValueTF = TextEditingController();
  final TextEditingController _timeFutureValueTF = TextEditingController();
  final TextEditingController _timeYearsTF = TextEditingController();
  
  String _timeAnnualInterestRate = '';

  @override
  void dispose() {
    _timePresentValueTF.dispose();
    _timeFutureValueTF.dispose();
    _timeYearsTF.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // TOP BG IMAGE
        backgroundImage(0.0, 0.0, null, null, 300.0, 300.0, 15.0 / 360.0),
        // BOTTOM BG IMAGE
        backgroundImage(null, null, 0.0, -20.0, 200.0, 200.0, -15.0 / 360.0),
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
                        // FUTURE VALUE TEXTFIELD
                        textfieldThousandsSeparator(
                          'Future value',
                          'Enter future value amount',
                          Text(Currency.php),
                          _timeFutureValueTF
                        ),
                        // TERM, YEARS TEXTFIELD
                        textfield(
                          'Term/Years',
                          'Enter term/years',
                          const Text('yr.'),
                          _timeYearsTF
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
                                    double P = double.parse(_timePresentValueTF.text.replaceAll(',', ''));
                                    double F = double.parse(_timeFutureValueTF.text.replaceAll(',', ''));
                                    double n = double.parse(_timeYearsTF.text);

                                    _timeAnnualInterestRate = ((1/n)*((F/P)-1)*100).toStringAsFixed(2);
                                    // SHOW RESULT DIALOG
                                    showGeneralDialog(
                                      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                      barrierDismissible: true,
                                      barrierColor: Colors.black.withOpacity(0.5),
                                      transitionDuration: const Duration(milliseconds: 300),
                                      context: context,
                                      pageBuilder: (_, __, ___) {
                                        return InterestRateDialog(timeAnnualInterestRate: _timeAnnualInterestRate);
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
                                  _timeFutureValueTF.clear();
                                  _timeYearsTF.clear();
                                });
                              }
                            )
                          )
                        ),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.all(3),
                          width: MediaQuery.of(context).size.width,
                          child: Text('Example: You are going to invest P500. To increase this amount to P710.00 in 7 years, what interest rate is necessary for a time deposit account? (Ans: 6.00% p.a.)',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.lightGreen[700],
                              fontSize: 16
                            )
                          )
                        ),
                        const SizedBox(height: 15)
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