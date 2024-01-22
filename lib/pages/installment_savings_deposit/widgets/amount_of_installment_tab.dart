import 'dart:math';

import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/pages/installment_savings_deposit/widgets/widgets.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class AmountOfInstallmentTab extends StatefulWidget {
  const AmountOfInstallmentTab({super.key});

  @override
  State<AmountOfInstallmentTab> createState() => AmountOfInstallmentState();
}

class AmountOfInstallmentState extends State<AmountOfInstallmentTab> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountDepositTF = TextEditingController();
  final TextEditingController _rateTF = TextEditingController();
  final TextEditingController _futureValueTF = TextEditingController();
  final TextEditingController _yearsTF = TextEditingController();

  int _compounding = 12;
  String _payment = '';

  @override
  void dispose() {
    _amountDepositTF.dispose();
    _rateTF.dispose();
    _futureValueTF.dispose();
    _yearsTF.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // TOP BG IMAGE
        backgroundImage(null, 0.0, 20.0, null, 300.0, 300.0, 15.0 / 360.0),
        // BOTTOM BG IMAGE
        backgroundImage(10.0, null, null, 0.0, 200.0, 200.0, 15.0 / 360.0),
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
                        // ANNUAL INTEREST TEXTFIELD
                        textfield(
                          'Interest Rate',
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
                        // YEARS TEXTFIELD
                        textfield('Year(s)', 'Enter number of year(s)', const Text('yr.'), _yearsTF),
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
                                    double P = 0.0;
                                    double r = double.parse(_rateTF.text)/100.0;
                                    double F = double.parse(_futureValueTF.text.replaceAll(',', ''));
                                    double n = double.parse(_yearsTF.text);

                                    double rate = r/_compounding;
                                    double term = n*_compounding;

                                    _payment = ((P*rate+F*rate*pow(1+rate,-term))/(1-pow(1+rate,-term))).toStringAsFixed(2);
                                    // SHOW RESULT DIALOG
                                    showGeneralDialog(
                                      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                      barrierDismissible: true,
                                      barrierColor:Colors.black.withOpacity(0.5),
                                      transitionDuration: const Duration(milliseconds: 300),
                                      context: context,
                                      pageBuilder: (_, __, ___) {
                                        return AmountInstallmentDialog(payment: _payment);
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
                                  _rateTF.clear();
                                  _futureValueTF.clear();
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
                          child: Text('Example: In order to save a total of P10,000 in 10 years, how much will each savings installment be at an annual interest rate of 6% compounded monthly? (Ans: P61.02/mo.)',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.lightGreen[700], fontSize: 16),
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
