import 'dart:math';

import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/pages/apds_financial/widgets/widgets.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class LoanAmountTab extends StatefulWidget {
  const LoanAmountTab({super.key});

  @override
  State<LoanAmountTab> createState() => LoanAmountState();
}

class LoanAmountState extends State<LoanAmountTab> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _loanAmountTF = TextEditingController();
  final TextEditingController _interestRateTF = TextEditingController();
  final TextEditingController _serviceFeeTF = TextEditingController();
  final TextEditingController _loanTermTF = TextEditingController();

  String _netProceeds = '';
  String _monthlyAmortization = '';

  @override
  void dispose() {
    _loanAmountTF.dispose();
    _interestRateTF.dispose();
    _serviceFeeTF.dispose();
    _loanTermTF.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // TOP IMAGE BACKGROUND
        backgroundImage(0.0, 0.0, null, null, 300.0, 300.0, 15.0 / 360.0),
        // BOTTOM IMAGE BACKGROUND
        backgroundImage(0.0, null, null, -20.0, 200.0, 200.0, -15.0 / 360.0),
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
                        // LOAN AMOUNT TEXTFIELD
                        textfieldThousandsSeparator(
                          'Loan Amount', 'Enter loan amount', 
                          Text(Currency.php),
                          _loanAmountTF
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
                        // LOAN TERM TEXTFIELD
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
                                foregroundColor: Colors.white,
                                backgroundColor: CustomColor.jewel,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8))
                                )
                              ),
                              child: const Text('CALCULATE', style: TextStyle(fontSize: 18)),
                              onPressed: () {
                                setState(() {
                                  if (_formKey.currentState!.validate()) {
                                    double P = double.parse(_loanAmountTF.text.replaceAll(',', ''));
                                    double r = double.parse(_interestRateTF.text)/100;
                                    double n = double.parse(_loanTermTF.text);
                                    double sf = double.parse(_serviceFeeTF.text)/100;

                                    double rate = r/12;

                                    double netProceeds = 0;
                                    double monthlyAmortization = 0;
                                    
                                    netProceeds = P*(1-sf);
                                    monthlyAmortization = P*((pow(1+rate, n)*rate)/(pow(1+rate, n)-1));

                                    if (netProceeds.isNaN) {
                                      netProceeds = 0;
                                    }
                                    if (monthlyAmortization.isNaN) {
                                      monthlyAmortization = 0;
                                    }
                                    
                                    _netProceeds = netProceeds.toStringAsFixed(2);
                                    _monthlyAmortization = monthlyAmortization.toStringAsFixed(2);
                                    // SHOW RESULT DIALOG
                                    showGeneralDialog(
                                      barrierLabel:MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                      barrierDismissible: true,
                                      barrierColor:Colors.black.withOpacity(0.5),
                                      transitionDuration:const Duration(milliseconds: 300),
                                      context: context,
                                      pageBuilder: (_, __, ___) {
                                        return LoanAmountDialog(
                                          monthlyAmortization: _monthlyAmortization,
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
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.grey,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8))
                                )
                              ),
                              child: const Text(
                                'CLEAR',
                                style: TextStyle(
                                  fontSize: 18
                                )
                              ),
                              onPressed: () {
                                setState(() {
                                  _formKey.currentState?.reset();
                                  _loanAmountTF.clear();
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
