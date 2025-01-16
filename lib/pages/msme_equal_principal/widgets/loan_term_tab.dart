import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/pages/msme_equal_principal/widgets/widgets.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class LoanTermTab extends StatefulWidget {
  const LoanTermTab({super.key});

  @override
  State<LoanTermTab> createState() => _LoanTermState();
}

class _LoanTermState extends State<LoanTermTab> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController loanAmtTF =  TextEditingController();
  final TextEditingController amortTF =  TextEditingController();
  final TextEditingController interestRatesTF =  TextEditingController();
  final TextEditingController sFTF =  TextEditingController();
  final TextEditingController gPTF =  TextEditingController();
  int _payModes = 12;
  String loanTerm = '';
  String netProceeds = '';
  String firstAmort = '';
  String lastAmort = '';
  String interestPerPeriodGP = '';
  String period = 'mo.';

  @override
  void dispose() {
    loanAmtTF.dispose();
    amortTF.dispose();
    interestRatesTF.dispose();
    sFTF.dispose();
    gPTF.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // TOP BG IMAGE
        backgroundImage(0.0, 0.0, null, null, 300.0, 300.0, 15.0 / 360.0),
        // BOTTOM BG IMAGE
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
                    key: formKey,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          width: MediaQuery.of(context).size.width,
                          child: Text('Pay Mode',textAlign: TextAlign.left,style: TextStyle(color: Colors.lightGreen[700])),
                        ),
                        // PAYMODE DROPDOWN BUTTON
                        CustomIntDropdown(
                          value: _payModes,
                          items: const [
                            DropdownMenuItem(value: 12,child: Text("Monthly")),
                            DropdownMenuItem(value: 4,child: Text("Quarterly")),
                            DropdownMenuItem(value: 2,child: Text("Semi-Annually")),
                            DropdownMenuItem(value: 1,child: Text("Annually")),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _payModes = value!;
                              paymodePeriod();
                            });
                          }
                        ),
                        // LOAN AMOUNT TEXTFIELD
                        textfieldThousandsSeparator('Loan Amount','Enter loan amount',Text(Currency.php),loanAmtTF),
                        // AMORTIZATION AMOUNT TEXTFIELD
                        textfieldThousandsSeparator('Amortization','Enter amortization amount',Text(Currency.php), amortTF),
                        // INTEREST RATE TEXTFIELD
                        textfield('Interest Rate','Enter interest rate per annum',const Text('%'),interestRatesTF),
                        // SERVICE FEE TEXTFIELD
                        textfield('Service Fee', 'Enter service fee',const Text('%'), sFTF),
                        // GRACE PERIOD TEXTFIELD
                        textfield('Grace Period', 'Enter grace period',Text(period), gPTF),
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
                                backgroundColor: CustomColor.jewel,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8))
                                )
                              ),
                              child: const Text(
                                'CALCULATE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                )
                              ),
                              onPressed: () {
                                setState(() {
                                  if (formKey.currentState!.validate()) {
                                    double gp = double.parse(gPTF.text);
                                    double amortization = double.parse(amortTF.text.replaceAll(',', ''));
                                    double interest = double.parse(interestRatesTF.text) / 100;
                                    double loan = double.parse(loanAmtTF.text.replaceAll(',', ''));
                                    double service = double.parse(sFTF.text) / 100;
                                    double result = ((loan /(amortization - (loan *(interest /_payModes)))) + gp) /_payModes;
                                    double net = loan * (1 - service);
                                    double resultDAP = (amortization - loan * interest /_payModes) * (1 + interest / _payModes);
                                    double interestGP = 0;
                                    if (gp == 0) {
                                      interestGP = 0;
                                    } else {
                                      interestGP = (loan * interest) / _payModes;
                                    }
                                    loanTerm = result.toStringAsFixed(2);
                                    netProceeds = net.toStringAsFixed(2);
                                    firstAmort = amortization.toStringAsFixed(2);
                                    lastAmort = resultDAP.toStringAsFixed(2);
                                    interestPerPeriodGP = interestGP.toStringAsFixed(2);
                                    // SHOW RESULT DIALOG
                                    showGeneralDialog(
                                      barrierLabel:MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                      barrierDismissible: true,
                                      barrierColor:Colors.black.withOpacity(0.5),
                                      transitionDuration:const Duration(milliseconds: 300),
                                      context: context,
                                      pageBuilder: (_, __, ___) {
                                        return LoanTermDialog(
                                          firstAmort: firstAmort,
                                          interestPerPeriodGP: interestPerPeriodGP,
                                          lastAmort: lastAmort,
                                          loanTerm: loanTerm,
                                          netProceeds: netProceeds,
                                        );
                                      },
                                      transitionBuilder:(_,anim,__,child) {
                                        return SlideTransition(
                                          position: Tween(
                                            begin: const Offset(0, -1),
                                            end: const Offset(0, 0)
                                          ).animate(anim),
                                          child: child,
                                        );
                                      },
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
                                  formKey.currentState?.reset();
                                  loanAmtTF.clear();
                                  amortTF.clear();
                                  interestRatesTF.clear();
                                  sFTF.clear();
                                  gPTF.clear();
                                  _payModes = 12;
                                  period = 'mo.';
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

  paymodePeriod() {
    if (_payModes == 1) {
      period = 'ay.';
    } else if (_payModes == 2) {
      period = 'sa.';
    } else if (_payModes == 4) {
      period = 'qy.';
    } else if (_payModes == 12) {
      period = 'mo.';
    }
  }
}