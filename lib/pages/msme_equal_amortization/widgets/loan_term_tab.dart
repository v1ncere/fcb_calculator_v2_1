import 'dart:math';

import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/pages/msme_equal_amortization/widgets/widgets.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class LoanTermTab extends StatefulWidget {
  const LoanTermTab({super.key});

  @override
  State<LoanTermTab> createState() => _LoanTermTabState();
}

class _LoanTermTabState extends State<LoanTermTab> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _loanAmountTF = TextEditingController();
  final TextEditingController _amortizationTF = TextEditingController();
  final TextEditingController _interestRateTF = TextEditingController();
  final TextEditingController _serviceFeeTF = TextEditingController();
  
  String _loanTermModes = '';
  String _netProceeds = '';
  String _loanTermYears = '';
  int _payMode = 12;

  @override
  void dispose() {
    _loanAmountTF.dispose();
    _amortizationTF.dispose();
    _interestRateTF.dispose();
    _serviceFeeTF.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // TOP BG IMAGE
        backgroundImage(null, 0.0, 0.0, null, 300.0, 300.0, 15.0 / 360.0),
        // BOTTOM BG IMAGE
        backgroundImage(0.0, null, null, -20.0, 200.0, 200.0, 15.0 / 360.0),
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
                            'Pay Mode',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.lightGreen[700])
                          )
                        ),
                        // PAYMODE DROPDOWN BUTTON
                        CustomIntDropdown(
                          value: _payMode,
                          items: const [
                            DropdownMenuItem(value: 12, child: Text("Monthly")),
                            DropdownMenuItem(value: 4, child: Text("Quarterly")),
                            DropdownMenuItem(value: 2, child: Text("Semi-Annually")),
                            DropdownMenuItem(value: 1, child: Text("Annually")),
                          ],
                          onChanged: (value) {
                            setState(() { 
                              _payMode = value!; 
                            });
                          }
                        ),
                        // LOAN AMOUNT TEXTFIELD
                        textfieldThousandsSeparator(
                          'Loan Amount', 'Enter loan amount', 
                          Text(Currency.php), 
                          _loanAmountTF
                        ),
                        // AMORTIZATIOM TEXTFIELD
                        textfieldThousandsSeparator(
                          'Amortization', 
                          'Enter amortization amount', 
                          Text(Currency.php), 
                          _amortizationTF
                        ),
                        // INTEREST RATE TEXTFIELD
                        textfield(
                          'Interest Rate', 
                          'Enter interest rate per annum', 
                          const Text('%'), 
                          _interestRateTF
                        ),
                        // SERVICE FEE TEXTFIELD
                        textfield(
                          'Service Fee', 
                          'Enter service fee', 
                          const Text('%'), 
                          _serviceFeeTF
                        ),
                        // HORIZONTAL LINE
                        line,
                        // CALCULTE BUTTON
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
                                  color: Colors.white,
                                )
                              ),
                              onPressed: () {
                                setState(() {
                                  if (_formKey.currentState!.validate()) {
                                    double payment = double.parse(_amortizationTF.text.replaceAll(',', ''));
                                    double interest = double.parse(_interestRateTF.text) / 100;
                                    double loan = double.parse(_loanAmountTF.text.replaceAll(',', ''));
                                    double service = double.parse(_serviceFeeTF.text) / 100;

                                    _loanTermYears = ((log(payment / (payment - interest / _payMode * loan)) / log(1 + interest / _payMode)) / _payMode).toStringAsFixed(2);
                                    _netProceeds = (loan * (1 - service)).toStringAsFixed(2);
                                    _loanTermModes = (Finance.nper(rate: interest / _payMode, pmt: -payment, pv: loan)).toStringAsFixed(2);

                                    String period = 'mo.';
                                    if (_payMode == 1) {
                                      period = ' ay.';
                                    } else if (_payMode == 2) {
                                      period = ' sa.';
                                    } else if (_payMode == 4) {
                                      period = ' qy.';
                                    } else if (_payMode == 12) {
                                      period = ' mo.';
                                    }
                                    // SHOW RESULT DIALOG
                                    showGeneralDialog(
                                      barrierLabel:MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                      barrierDismissible: true,
                                      barrierColor:Colors.black.withOpacity(0.5),
                                      transitionDuration: const Duration(milliseconds: 300),
                                      context: context,
                                      pageBuilder: (_, __, ___) {
                                        return LoanTermDialog(
                                          period: period,
                                          loanTermModes: _loanTermModes,
                                          loanTermYears: _loanTermYears,
                                          netProceeds: _netProceeds,
                                        );
                                      },
                                      transitionBuilder:(_,anim, __,child) {
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
                                  _loanAmountTF.clear();
                                  _amortizationTF.clear();
                                  _interestRateTF.clear();
                                  _serviceFeeTF.clear();
                                  _payMode = 12;
                                });
                              }
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