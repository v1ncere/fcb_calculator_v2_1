import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/pages/installment_savings_deposit/widgets/widgets.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class InterestRateInstallmentSavingsTab extends StatefulWidget {
  const InterestRateInstallmentSavingsTab({super.key});

  @override
  State<InterestRateInstallmentSavingsTab> createState() => _InterestRateInstallmentSavingsState();
}

class _InterestRateInstallmentSavingsState extends State<InterestRateInstallmentSavingsTab> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _monthlyDepositTF = TextEditingController();
  final TextEditingController _yearsTF = TextEditingController();
  final TextEditingController _futureValueTF = TextEditingController();

  String _ratePerPeriodBeginning = '';
  String _ratePerAnnumBeginning = '';
  String _ratePerPeriodEnd = '';
  String _ratePerAnnumEnd = '';

  int _compounding = 12;

  @override
  void dispose() {
    _monthlyDepositTF.dispose();
    _yearsTF.dispose();
    _futureValueTF.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // TOP BG IMAGE
        backgroundImage(30.0, -20.0, null, null, 300.0, 300.0, 15.0 / 360.0),
        // BOTTOM BG IMAGE
        backgroundImage(null, null, 45.0, -20.0, 200.0, 200.0, -15.0 / 360.0),
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
                        // COUMPOUNDING DROPDOWN BUTTON
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
                        // PERIODIC DEPOSIT TEXTFIELD
                        textfieldThousandsSeparator(
                          'Periodic Deposit',
                          'Enter periodic deposit',
                          Text(Currency.php),
                          _monthlyDepositTF
                        ),
                        // FUTURE VALUE TEXTFIELD
                        textfieldThousandsSeparator(
                          'Future Value',
                          'Enter future value',
                          Text(Currency.php),
                          _futureValueTF
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
                                    double F = double.parse(_futureValueTF.text.replaceAll(',', ''));
                                    double n = double.parse(_yearsTF.text)*_compounding;

                                    num rateBeginning = (Finance.rate(nper: n, pmt: -A, pv: P, fv: F, end: false))*100;
                                    _ratePerPeriodBeginning = rateBeginning.toStringAsFixed(2);
                                    _ratePerAnnumBeginning = (rateBeginning * _compounding).toStringAsFixed(2);

                                    num rateEnd = (Finance.rate(nper: n, pmt: -A, pv: P, fv: F))*100;
                                    _ratePerPeriodEnd = rateEnd.toStringAsFixed(2);
                                    _ratePerAnnumEnd = (rateEnd * _compounding).toStringAsFixed(2);
                                    // SHOW RESULT DIALOG
                                    showGeneralDialog(
                                      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                      barrierDismissible: true,
                                      barrierColor:Colors.black.withOpacity(0.5),
                                      transitionDuration: const Duration(milliseconds: 300),
                                      context: context,
                                      pageBuilder: (_, __, ___) {
                                        return InterestRateInstallmentSavingsDialog(
                                          period: getTermString(_compounding),
                                          ratePerPeriodBeginning: _ratePerPeriodBeginning,
                                          ratePerAnnumBeginning: _ratePerAnnumBeginning,
                                          ratePerPeriodEnd: _ratePerPeriodEnd,
                                          ratePerAnnumEnd: _ratePerAnnumEnd,
                                        );
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
                                  _monthlyDepositTF.clear();
                                  _yearsTF.clear();
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
                          child: Text('Example: What rate of annual interest is necessary so that a monthly installment payments of P60 will reach a principal + interest total of P10,000 in 10 years. (Ans: 6.31% p.a.)',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.lightGreen[700], fontSize: 16),
                          )
                        ),
                        const SizedBox(height: 10),
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