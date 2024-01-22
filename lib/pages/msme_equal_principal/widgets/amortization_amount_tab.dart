import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/pages/msme_equal_principal/widgets/widgets.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class AmortizationAmountTab extends StatefulWidget {
  const AmortizationAmountTab({super.key});

  @override
  State<AmortizationAmountTab> createState() => _AmortizationAmountState();
}

class _AmortizationAmountState extends State<AmortizationAmountTab> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _loanAmtTF = TextEditingController();
  final TextEditingController _interestRateTF = TextEditingController();
  final TextEditingController _loanTermTF = TextEditingController();
  final TextEditingController _serviceFeeTF = TextEditingController();
  final TextEditingController _gracePeriodTF = TextEditingController();
  
  String _firstAmortPmt = '';
  String _lastAmortPmt = '';
  String _netProceeds = '';
  String _interestPerPeriodDuringGP = '';
  String _period = 'mo.';
  int _payModes = 12;

  @override
  void dispose() {
    _loanAmtTF.dispose();
    _interestRateTF.dispose();
    _loanTermTF.dispose();
    _serviceFeeTF.dispose();
    _gracePeriodTF.dispose();
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
                          child:  Text(
                            'Pay Mode',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.lightGreen[700])
                          ),
                        ),
                        // PAYMODE DROPDOWN BUTTON
                        CustomIntDropdown(
                          value: _payModes,
                          items: const [
                            DropdownMenuItem(value: 12, child: Text("Monthly")),
                            DropdownMenuItem(value: 4, child: Text("Quarterly")),
                            DropdownMenuItem(value: 2, child: Text("Semi-Annually")),
                            DropdownMenuItem(value: 1, child: Text("Annually")),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _payModes = value!;
                              paymodePeriod();
                            });
                          }
                        ),
                        // LOAN AMOUNT TEXTFIELD
                        textfieldThousandsSeparator(
                          'Loan Amount',
                          'Enter loan amount',
                          Text(Currency.php),
                          _loanAmtTF
                        ),
                        // INTEREST RATE TEXTFIELD
                        textfield(
                          'Interest Rate',
                          'Enter interest rate per annum',
                          const Text('%'),
                          _interestRateTF
                        ),
                        // LOAN TERM, YEAR TEXTFIELD
                        textfield(
                          'Term/Years', 
                          'Enter term/years',
                          const Text('yr.'),
                          _loanTermTF
                        ),
                        // SERVICE FEE TEXTFIELD
                        textfield(
                          'Service Fee',
                          'Enter service fee',
                          const Text('%'),
                          _serviceFeeTF
                        ),
                        // GRACE PERIOD TEXTFIELD
                        textfield(
                          'Grace Period on Principal',
                          'Enter grace period on principal',
                          Text(_period),
                          _gracePeriodTF
                        ),
                        // HORIZONTAL LINE
                        line,
                        // CALCULATE BUTTON
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
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
                                    double gp = double.parse(_gracePeriodTF.text);
                                    double service = double.parse(_serviceFeeTF.text) / 100;
                                    double rate = double.parse(_interestRateTF.text) / 100;
                                    double loan = double.parse(_loanAmtTF.text.replaceAll(',', ''));
                                    double year = double.parse(_loanTermTF.text);
                                    double resInitial = (loan / ((year * _payModes) - gp)) + (loan * (rate / _payModes));
                                    double resLast = (loan / ((year * _payModes) - gp)) * (1 + (rate / _payModes));
                                    double net = loan * (1 - service);
                                    double interestGP = 0;
                                    if (gp == 0) {
                                      interestGP = 0;
                                    } else {
                                      interestGP = (loan * rate) / _payModes;
                                    }
                                    _firstAmortPmt = resInitial.toStringAsFixed(2);
                                    _lastAmortPmt = resLast.toStringAsFixed(2);
                                    _netProceeds = net.toStringAsFixed(2);
                                    _interestPerPeriodDuringGP = interestGP.toStringAsFixed(2);
                                    // SHOW RESULT DIALOG
                                    showGeneralDialog(
                                      barrierLabel:MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                      barrierDismissible: true,
                                      barrierColor:Colors.black.withOpacity(0.5),
                                      transitionDuration:const Duration(milliseconds: 300),
                                      context: context,
                                      pageBuilder: (_,__,___) {
                                        return AmortizationAmountDialog(
                                          firstAmortPmt: _firstAmortPmt,
                                          interestPerPeriodDuringGP: _interestPerPeriodDuringGP,
                                          lastAmortPmt: _lastAmortPmt,
                                          netProceeds: _netProceeds,
                                        );
                                      },
                                      transitionBuilder:(_, anim, __, child) {
                                        return SlideTransition(
                                          position: Tween(begin: const Offset(0, -1),end: const Offset(0, 0)).animate(anim),
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
                                  _loanAmtTF.clear();
                                  _interestRateTF.clear();
                                  _loanTermTF.clear();
                                  _serviceFeeTF.clear();
                                  _gracePeriodTF.clear();
                                  _payModes = 12;
                                  _period = 'mo.';
                                });
                              }
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

  paymodePeriod() {
    if (_payModes == 1) {
      _period = 'ay.';
    } else if (_payModes == 2) {
      _period = 'sa.';
    } else if (_payModes == 4) {
      _period = 'qy.';
    } else if (_payModes == 12) {
      _period = 'mo.';
    }
  }
}
