import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_calculator_v2_1/app/app.dart';
import 'package:fcb_calculator_v2_1/pages/apds_financial/apds_financial.dart';
import 'package:fcb_calculator_v2_1/pages/home/widgets/widgets.dart';
import 'package:fcb_calculator_v2_1/pages/installment_savings_deposit/installment_savings_deposit.dart';
import 'package:fcb_calculator_v2_1/pages/msme_equal_amortization/msme_equal_amortization.dart';
import 'package:fcb_calculator_v2_1/pages/msme_equal_principal/msme_equal_principal.dart';
import 'package:fcb_calculator_v2_1/pages/savings_deposit/savings_deposit.dart';
import 'package:fcb_calculator_v2_1/pages/time_deposit/time_deposit.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeState();
}

class HomeState extends State<HomeView> with WidgetsBindingObserver {
  Timer? expirationTimer;

  @override
  void initState() {
    super.initState();
    expirationTimer = Timer.periodic(const Duration(minutes: 2), (_) {
      context.read<AppBloc>().add(CheckUserExpiration());
    });
  }

  @override
  void dispose() {
    expirationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const SideDrawer(),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            /// TITLE
            const Positioned(
              top: 20,
              child: TitleTexts()
            ),
            /// BACKGROUND LAYOUT
            Positioned(
              top: 80,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.amberAccent[100],
                  borderRadius: BorderRadius.circular(25)
                )
              )
            ),
            /// TOP BACKGROUND IMAGE
            backgroundImage(null, 110.0, 20.0, null, 150.0, 150.0, 15.0 / 360.0),
            /// BOTTOM BACKGROUND IMAGE
            backgroundImage(50.0, null, null, 10.0, 250.0, 250.0, 15.0 / 360.0),
            /// BUTTONS
            LayoutBuilder(
              builder:(BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
                    child: Column(
                      children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 115, 10, 35),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            /// APDS FINANCIAL BUTTON
                            customHomeButton(context,
                              'APDS FINANCIAL',
                              () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const APDSFinancialPage()));
                              }
                            ),
                            const SizedBox(height: 8),
                            /// MSME EQUAL PRINCIPAL BUTTON
                            customHomeButton(
                              context,
                              'MSME EQUAL PRINCIPAL',
                              () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const MSMEEqualPrincipalPage()));
                              }
                            ),
                            const SizedBox(height: 8),
                            /// MSME EQUAL AMORTIZATION BUTTON
                            customHomeButton(
                              context,
                              "MSME EQUAL AMORTIZATION",
                              () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const MSMEEqualAmortizationPage()));
                              }
                            ),
                            const SizedBox(height: 8),
                            /// SAVINGS DEPOSIT COMPOUNDED BUTTON
                            customHomeButton(
                              context,
                              'SAVINGS DEPOSIT COMPOUNDED',
                              () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const SavingsDepositPage()));
                              }
                            ),
                            const SizedBox(height: 8,),
                            /// TIME DEPOSIT NOT COMPOUNDED BUTTON
                            customHomeButton(
                              context,
                              'TIME DEPOSIT NOT COMPOUNDED',
                              () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const TimeDepositPage()));
                              }
                            ),
                            const SizedBox(height: 8,),
                            /// INSTALLMENT SAVINGS DEPOSIT BUTTON
                            customHomeButton(
                              context,
                              'INSTALLMENT SAVINGS DEPOSIT',
                              () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const InstallmentSavingsDepositPage()));
                              }
                            ),
                          ]
                        )
                      )
                    ])
                  )
                );
              }
            ),
            // FooterText(expiration: _expirationDate)
          ]
        )
      )
    );
  }
}