import 'dart:math';

import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/pages/installment_savings_deposit/widgets/widgets.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class NumberOfInstallmentsTab extends StatefulWidget {
  const NumberOfInstallmentsTab({super.key});

  @override
  State<NumberOfInstallmentsTab> createState() => NumberOfInstallmentState();
}

class NumberOfInstallmentState extends State<NumberOfInstallmentsTab> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountDepositTF = TextEditingController();
  final TextEditingController _monthlyDepositTF = TextEditingController();
  final TextEditingController _rateTF = TextEditingController();
  final TextEditingController _futureValueTF = TextEditingController();
  
  int _compounding = 12;
  String _period = '';

  @override
  void dispose() {
    _amountDepositTF.dispose();
    _monthlyDepositTF.dispose();
    _rateTF.dispose();
    _futureValueTF.dispose();
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
                          }
                        ),
                        // AMOUNT DEPOSIT TEXTFIELD
                        textfieldDisable(
                          'Downpayment',
                          '0',
                          Text(Currency.php)
                        ),
                        // PERIODIC DEPOSIT TEXTFIELD
                        textfieldThousandsSeparator(
                          'Periodic Deposit',
                          'Enter periodic deposit',
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
                        // FUTURE VALUE TEXTFIELD
                        textfieldThousandsSeparator(
                          'Future Value',
                          'Enter future value',
                          Text(Currency.php),
                          _futureValueTF
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
                                    double P = 0.0;
                                    double A = double.parse(_monthlyDepositTF.text.replaceAll(',', ''));
                                    double r = double.parse(_rateTF.text)/100;
                                    double F = double.parse(_futureValueTF.text.replaceAll(',', ''));

                                    double rate = r/_compounding;

                                    _period = (log((A+F*rate)/(A+P*rate))/log(1+rate)*(1/_compounding)).toStringAsFixed(2);
                                    // SHOW RESULT DIALOG
                                    showGeneralDialog(
                                      barrierLabel:MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                      barrierDismissible: true,
                                      barrierColor:Colors.black.withOpacity(0.5),
                                      transitionDuration: const Duration(milliseconds: 300),
                                      context: context,
                                      pageBuilder: (_, __, ___) {
                                        return NumberOfInstallmentsDialog(period: _period);
                                      },
                                      transitionBuilder: (_, anim, __, child) {
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
                                  _monthlyDepositTF.clear();
                                  _rateTF.clear();
                                  _futureValueTF.clear();
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
                          child: Text('Example: How many monthly installment deposits of P84 must be made to reach a goal of P6,000 at an annual interest rate of 6% compounded monthly? (Ans: 5.10 yrs or 61.2 mos.)',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.lightGreen[700],
                              fontSize: 16,
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