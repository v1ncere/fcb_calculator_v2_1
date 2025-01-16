import 'dart:math';

import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/pages/installment_savings_deposit/widgets/widgets.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class TotalPrincipalAndInterestTab extends StatefulWidget {
  const TotalPrincipalAndInterestTab({super.key});

  @override
  State<TotalPrincipalAndInterestTab> createState() => TotalPrincipalAndInterestTabState();
}

class TotalPrincipalAndInterestTabState extends State<TotalPrincipalAndInterestTab> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountDepositTF = TextEditingController();
  final TextEditingController _monthlyDepositTF = TextEditingController();
  final TextEditingController _rateTF = TextEditingController();
  final TextEditingController _yearsTF = TextEditingController();
  
  int _compounding = 12;
  String _futureValue = '';

  @override
  void dispose() {
    _amountDepositTF.dispose();
    _monthlyDepositTF.dispose();
    _rateTF.dispose();
    _yearsTF.dispose();
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
                          },
                        ),
                        // AMOUNT DEPOSIT TEXTFIELD
                        textfieldThousandsSeparator(
                          'Downpayment', 'Enter downpayment amount',
                          Text(Currency.php),
                          _amountDepositTF
                        ),
                        // PERIODIC DEPOSIT TEXTFIELD
                        textfieldThousandsSeparator(
                          'Periodic deposit', 'Enter periodic deposit',
                          Text(Currency.php),
                          _monthlyDepositTF
                        ),
                        // ANNUAL INTEREST RATE TEXTFIELD
                        textfield(
                          'Interest',
                          'Enter interest rate',
                          const Text('%'),
                          _rateTF
                        ),
                        // YEARS TEXTFIELD
                        textfield(
                          'Year(s)', 
                          'Enter number of year(s)',
                          const Text('yr.'),
                          _yearsTF
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
                                    double P = double.parse(_amountDepositTF.text.replaceAll(',', ''));
                                    double A = double.parse(_monthlyDepositTF.text.replaceAll(',', ''));
                                    double r = double.parse(_rateTF.text)/100;
                                    double n = double.parse(_yearsTF.text);
                                    
                                    double rate = r/_compounding;
                                    double term = n*_compounding;

                                    _futureValue = (P*(pow(1+rate, term))+A*(pow(1+rate, term)-1)/rate).toStringAsFixed(2);
                                    // SHOW RESULT DIALOG
                                    showGeneralDialog(
                                      barrierLabel:MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                      barrierDismissible: true,
                                      barrierColor:Colors.black.withOpacity(0.5),
                                      transitionDuration: const Duration(milliseconds: 300),
                                      context: context,
                                      pageBuilder: (_, __, ___) {
                                        return TotalPrincipalAndInterestDialog(
                                          futureValue: _futureValue
                                        );
                                      },
                                      transitionBuilder:(_, anim, __, child) {
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
                        // CLEAR BUTTON
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
                                  _amountDepositTF.clear();
                                  _monthlyDepositTF.clear();
                                  _rateTF.clear();
                                  _yearsTF.clear();
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
                          child: Text('Example: 1: If you invest P250 in installment savings each month for 5 years at 6% annual interest, compounded monthly, what will the total of principal and interest be at the end of the term? (Ans: P17,442.51)',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.lightGreen[700], fontSize: 16),
                          )
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(3),
                          width: MediaQuery.of(context).size.width,
                          child: Text('Example: 2: What is the total principal and interest after 5 years if an installment savings account is opened with a down payment of P1,000 and installment of P250 are added each month at an interest rate of 6.00%, compounded monthly. (Ans: P18,791.36)',
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
