import 'dart:math';

import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/pages/apds_financial/widgets/widgets.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class AmortizationTab extends StatefulWidget {
  const AmortizationTab({super.key});

  @override
  State<AmortizationTab> createState() => AmortizationState();
}

class AmortizationState extends State<AmortizationTab> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _monthlyAmortizationTF = TextEditingController();
  final TextEditingController _interestRateTF = TextEditingController();
  final TextEditingController _serviceFeeTF = TextEditingController();
  final TextEditingController _loanTermTF = TextEditingController();
  
  String _loanAmount = '';
  String _netProceeds = '';

  @override
  void dispose() {
    _monthlyAmortizationTF.dispose();
    _interestRateTF.dispose();
    _serviceFeeTF.dispose();
    _loanTermTF.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // TOP BACKGROUND IMAGE
        backgroundImage(0.0, 0.0, null, null, 300.0, 300.0, 15.0 / 360.0),
        // BOTTOM BACKGROUND IMAGE
        backgroundImage(null, null, 0.0, -20.0, 200.0, 200.0, 15.0 / 360.0),
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
                        // MONTHLY AMORTIZATION TEXTFIELD
                        textfieldThousandsSeparator(
                          'Monthly Amortization',
                          'Enter monthly amortization amount',
                          Text(Currency.php),
                          _monthlyAmortizationTF
                        ),
                        // INTEREST RATE TEXTFIELD
                        textfield(
                          'Interest Rate',
                          'Enter interest rate',
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
                        // TERM TEXTFIELD
                        textfield(
                          'Loan Term',
                          'Enter loan period',
                          const Text('mo.'),
                          _loanTermTF
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
                                backgroundColor: CustomColors.jewel,
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
                                    double A = double.parse(_monthlyAmortizationTF.text.replaceAll(',', ''));
                                    double r = double.parse(_interestRateTF.text)/100;
                                    double n = double.parse(_loanTermTF.text);
                                    double sf = double.parse( _serviceFeeTF.text)/100;
                                    
                                    double rate = r/12;

                                    double loanAmount = A*((pow(1+rate,n)-1)/(pow(1+rate,n)*rate));
                                    double netProceeds = loanAmount * (1 - sf);
                                    
                                    if (loanAmount.isNaN) {
                                      loanAmount = 0;
                                    }
                                    if (netProceeds.isNaN) {
                                      netProceeds = 0;
                                    }
                
                                    _loanAmount = loanAmount.toStringAsFixed(2);
                                    _netProceeds = netProceeds.toStringAsFixed(2);
                                    // SHOW RESULT DIALOG
                                    showGeneralDialog(
                                      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                      barrierDismissible: true,
                                      barrierColor:Colors.black.withOpacity(0.5),
                                      transitionDuration: const Duration(milliseconds: 300),
                                      context: context,
                                      pageBuilder: (_, __, ___) {
                                        return AmortizationDialog(
                                          loanAmount: _loanAmount,
                                          netProceeds: _netProceeds,
                                        );
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
                                  color: Colors.white,
                                )
                              ),
                              onPressed: () {
                                setState(() {
                                  _formKey.currentState?.reset();
                                  _monthlyAmortizationTF.clear();
                                  _interestRateTF.clear();
                                  _serviceFeeTF.clear();
                                  _loanTermTF.clear();
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
