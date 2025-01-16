import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/pages/time_deposit/widgets/widgets.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class TotalPrincipalInterestTab extends StatefulWidget {
  const TotalPrincipalInterestTab({super.key});

  @override
  State<TotalPrincipalInterestTab> createState() => _TotalPrincipalInterestTabState();
}

class _TotalPrincipalInterestTabState extends State<TotalPrincipalInterestTab> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _timePresentValueTF = TextEditingController();
  final TextEditingController _timeAnnualInterestRateTF = TextEditingController();
  final TextEditingController _timeYearsTF = TextEditingController();
  
  String _timeFutureValue = '';

  @override
  void dispose() {
    _timePresentValueTF.dispose();
    _timeAnnualInterestRateTF.dispose();
    _timeYearsTF.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // TOP BG IMAGE
        backgroundImage(null, 0.0, 0.0, null, 300.0, 300.0, 15.0 / 360.0),
        // BOTTOM BG IMAGE
        backgroundImage(0.0, null, null, -20.0, 200.0, 200.0, -15.0 / 360.0),
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
                          const Text('%'), _timeAnnualInterestRateTF
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
                            padding: const EdgeInsets.all(3),
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
                                    double r = double.parse(_timeAnnualInterestRateTF.text)/100;
                                    double n = double.parse(_timeYearsTF.text);
                                    
                                    double period = r*n;

                                    _timeFutureValue = (P*(1+period)).toStringAsFixed(2);
                                    // SHOW RESULT DIALOG
                                    showGeneralDialog(
                                      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                      barrierDismissible: true,
                                      barrierColor:Colors.black.withOpacity(0.5),
                                      transitionDuration: const Duration(milliseconds: 300),
                                      context: context,
                                      pageBuilder: (_, __, ___) {
                                        return TotalPrincipalInterestDialog(timeFutureValue: _timeFutureValue);
                                      },
                                      transitionBuilder:(_,anim,__,child) {
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
                          child: Text('Example: What is the total principal and interest after 7 years for a principal of P500 at 6% p.a.? (Ans: P710.00)',
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
