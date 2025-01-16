import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

import 'package:fcb_calculator_v2_1/pages/apds_financial/widgets/widgets.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class APDSLoanTab extends StatefulWidget {
  const APDSLoanTab({super.key});
  
  @override
  State<APDSLoanTab> createState() => APDSLoanState();
}

class APDSLoanState extends State<APDSLoanTab> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _loanTermTF = TextEditingController();
  final TextEditingController _deductionTF = TextEditingController();
  final TextEditingController _interestRateTF = TextEditingController();
  
  DateTime? _effectivityDate;
  DateTime? _cutOffDate;

  String _billingPeriod = 'Next_Month';
  String _loanType = 'PLI';

  @override
  void initState() {
    super.initState();
    _effectivityDate = DateTime.now();
    _cutOffDate = DateTime.now();
  }

  @override
  void dispose() {
    _loanTermTF.dispose();
    _deductionTF.dispose();
    _interestRateTF.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // TOP IMAGE BACKGROUND
        backgroundImage(null, 0.0, null, null, 300.0, 300.0, 15.0 / 360.0),
        // BOTTOM IMAGE BACKGROUND
        backgroundImage(0.0, null, null, -20.0, 200.0, 200.0, 15.0 / 360.0),
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
                        // BUTTON TITLE
                        const Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: DropdownButtonTitle(title: 'Billing Period:')
                            ),
                            Expanded(
                              flex: 1,
                              child: DropdownButtonTitle(title: 'Loan Type:')
                            )
                          ]
                        ),
                        // DROPDOWN BUTTONS
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: CustomStringDropdown(
                                value: _billingPeriod,
                                items: const [
                                  DropdownMenuItem(value: 'Next_Month', child: Text("Next Month")),
                                  DropdownMenuItem(value: 'Next_Next_Month', child: Text("Next Next Month")),
                                ],
                                onChanged: (value) {
                                  setState(() { _billingPeriod = value!; });
                                }
                              )
                            ),
                            Expanded(
                              flex: 1,
                              child: CustomStringDropdown(
                                value: _loanType,
                                items: const [
                                  DropdownMenuItem(value: 'PLI', child: Text('PLI')),
                                  DropdownMenuItem(value: 'GFAL', child: Text('GFAL')),
                                ],
                                onChanged: (value) {
                                  setState(() { _loanType = value!; });
                                }
                              )
                            )
                          ]
                        ),
                        // LOAN PERIOD TEXTFIELD
                        textfield(
                          'Loan Term',
                          'Enter loan period',
                          const Text('mo.'),
                          _loanTermTF
                        ),
                        // DEDUCTION AMOUNT TEXTFIELD
                        textfieldThousandsSeparator(
                          'Deduction', 'Enter deduction amount',
                          Text(Currency.php),
                          _deductionTF
                        ),
                        // INTEREST RATE TEXTFIELD
                        textfield(
                          'Interest Rate',
                          'Enter interest rate',
                          const Text('%'),
                          _interestRateTF
                        ),
                        // DATE PICKER BUTTONS
                        Row(
                          children: [
                            Expanded(
                              child: CustomButtons(
                                title: 'Effective Date',
                                onPressed: () {
                                  effDatePicker();
                                }
                              )
                            ),
                            Expanded(
                              child: CustomButtons(
                                title: 'Loan Balance, Cut Off Date',
                                onPressed: () {
                                  cutOffDatePicker();
                                }
                              )
                            )
                          ]
                        ),
                        // DATE DISPLAY TEXT
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(getDateString(_effectivityDate!),
                                    style: const TextStyle(
                                      color: Colors.black45,
                                      fontSize: 18
                                    )
                                  )
                                )
                              )
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(getDateString(_cutOffDate!),
                                    style: const TextStyle(
                                      color: Colors.black45,
                                      fontSize: 18
                                    )
                                  )
                                )
                              )
                            )
                          ]
                        ),
                        // HORIZONTAL LINE
                        Row(
                          children: [
                            Expanded(child: line,),
                            Expanded(child: line,)
                          ],
                        ),
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
                              child: const Text('CALCULATE',style: TextStyle(fontSize: 18)),
                              onPressed: () {
                                setState(() {
                                  if (_formKey.currentState!.validate()) {
                                    double A = double.parse(_deductionTF.text.replaceAll(',', ''));
                                    double r = double.parse(_interestRateTF.text)/100;
                                    double n = double.parse(_loanTermTF.text);                
                                    double rate = r/12;
                                    double monthlyAmortization = 0;
                                    double loanAmount = 0;
                                    double outstandingBalance = 0;

                                    num _intermidiatePeriod = Jiffy(_cutOffDate).diff(Jiffy(_effectivityDate), Units.MONTH);

                                    String _monthlyAmortization = (_deductionTF.text.replaceAll(',', ''));
                                    String _loanAmount = '';
                                    String _outstandingBalance = '';

                                    if (_loanType == "PLI") {
                                      monthlyAmortization = double.parse(_monthlyAmortization);
                                      _monthlyAmortization = monthlyAmortization.toStringAsFixed(2);
                                      
                                      loanAmount = double.parse(_monthlyAmortization)*((pow(1+rate, n)-1)/(pow(1+rate, n)*rate));
                                      _loanAmount = loanAmount.toStringAsFixed(2);
                                    } else {
                                      loanAmount = (12000*n*A)/(12000+64.56*n);
                                      _loanAmount = loanAmount.toStringAsFixed(2);

                                      monthlyAmortization = (A-double.parse(_loanAmount)/1000*0.38);
                                      _monthlyAmortization = monthlyAmortization.toStringAsFixed(2);
                                    }
                                    
                                    // OUTSTANDING BALANCE
                                    DateTime effectivityDate = DateTime.parse(DateFormat(DateStrings.dateFormat).format(_effectivityDate!));

                                    if (effectivityDate.isAfter(Date.byhnEnd)) {
                                      outstandingBalance = (double.parse(_loanAmount)*((pow(1+rate, n))-(pow(1+rate, _intermidiatePeriod)))/((pow(1+rate, n))-1))*(1+rate);
                                      _outstandingBalance = outstandingBalance.toStringAsFixed(2);
                                    } else {
                                      DateTime effDate = DateTime.parse(DateFormat(DateStrings.dateFormat).format(_effectivityDate!));
                                      DateTime lBCutOffDate = DateTime.parse(DateFormat(DateStrings.dateFormat).format(_cutOffDate!));

                                      double interest = 0;
                                      int amortizationPeriod = 1;
                                      double installment = 0;
                                      double principal = 0;
                                      double prevbalance = double.parse(_loanAmount);
                                      double currentbal = 0;
                                      double estBal = 0;

                                      while (effDate.isBefore(lBCutOffDate) || (effDate.isAtSameMomentAs(lBCutOffDate))) {
                                        
                                        outstandingBalance = double.parse(_loanAmount);
                                        
                                        // INTEREST
                                        interest = _loanType == "GFAL" &&
                                        effDate.isAtSameMomentAs(Date.byhn_1) || 
                                        effDate.isAtSameMomentAs(Date.byhn_2) ||
                                        effDate.isAtSameMomentAs(Date.byhn_3) || 
                                        effDate.isAtSameMomentAs(Date.byhn_4)
                                        ? 0
                                        : (amortizationPeriod <= 1)
                                          ? (_billingPeriod == 'Next_Month')
                                            ? double.parse((prevbalance*rate).toStringAsFixed(2))
                                            : double.parse(((prevbalance*rate)).toStringAsFixed(2))*2
                                          : double.parse((prevbalance*rate).toStringAsFixed(2));

                                        // INSTALLMENT
                                        installment = (amortizationPeriod <= (n+4))
                                        ? (effDate.isAtSameMomentAs(Date.byhn_1) ||
                                          effDate.isAtSameMomentAs(Date.byhn_2) ||
                                          effDate.isAtSameMomentAs(Date.byhn_3) ||
                                          effDate.isAtSameMomentAs(Date.byhn_4))
                                          ? 0
                                          : (amortizationPeriod == 0) ? 0 : monthlyAmortization
                                        : 0;

                                        // PRINCIPAL
                                        principal = (amortizationPeriod <= (n+4))
                                        ? ((installment-interest) <= 0) ? 0 : installment-interest 
                                        : 0;

                                        // BALANCE
                                        currentbal = amortizationPeriod <= (n+4)
                                        ? ((prevbalance-principal) > 0) ? prevbalance-principal : 0
                                        : 0;

                                        estBal = prevbalance+interest;
                                        prevbalance = currentbal;
                                        effDate =  DateTime(effDate.year, effDate.month+1, effDate.day);
                                        amortizationPeriod++;
                                      }

                                      _outstandingBalance = estBal.toStringAsFixed(2);
                                    }

                                    /// SHOW RESULT DIALOG
                                    showGeneralDialog(
                                      barrierLabel:MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                      barrierDismissible: true,
                                      barrierColor:Colors.black.withOpacity(0.5),
                                      transitionDuration: const Duration(milliseconds: 300),
                                      context: context,
                                      pageBuilder: (_, __, ___) {
                                        return APDSLoanDialog(
                                          loanAmount: _loanAmount,
                                          monthlyAmortization: _monthlyAmortization,
                                          outstandingBalance: _outstandingBalance,
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
                                  color: Colors.white
                                )
                              ),
                              onPressed: () {
                                setState(() {
                                  _formKey.currentState?.reset();
                                  _loanTermTF.clear();
                                  _deductionTF.clear();
                                  _interestRateTF.clear();
                                  _billingPeriod = 'Next_Month';
                                  _loanType = 'PLI';
                                  _effectivityDate = DateTime.now();
                                  _cutOffDate = DateTime.now();
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

  void effDatePicker() {
    DatePicker.showDatePicker(
      context,
      onMonthChangeStartWithFirstDate: true,
      pickerTheme: const DateTimePickerTheme(
        showTitle: true,
        confirm: Text('OK')
      ),
      minDateTime: DateTime.parse(DateStrings.minDateTime),
      maxDateTime: DateTime.parse(DateStrings.maxDateTime),
      initialDateTime: _effectivityDate,
      dateFormat: DateStrings.pickerFormat,
      onChange: (dateTime, List<int> index) {
        setState(() {
          _effectivityDate = dateTime;
        });
      },
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _effectivityDate = dateTime;
        });
      }
    );
  }

    void cutOffDatePicker() {
    DatePicker.showDatePicker(
      context,
      onMonthChangeStartWithFirstDate: true,
      pickerTheme: const DateTimePickerTheme(
        showTitle: true,
        confirm: Text('OK')
      ),
      minDateTime: DateTime.parse(DateStrings.minDateTime),
      maxDateTime: DateTime.parse(DateStrings.maxDateTime),
      initialDateTime: _cutOffDate,
      dateFormat: DateStrings.pickerFormat,
      onChange: (dateTime, List<int> index) {
        setState(() {
          _cutOffDate = dateTime;
        });
      },
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _cutOffDate = dateTime;
        });
      }
    );
  }
}
