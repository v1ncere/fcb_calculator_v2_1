import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/pages/installment_savings_deposit/widgets/widgets.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class InstallmentSavingsDepositPage extends StatefulWidget {
  const InstallmentSavingsDepositPage({super.key});

  @override
  State<InstallmentSavingsDepositPage> createState() => _InstallmentSavings();
}

class _InstallmentSavings extends State<InstallmentSavingsDepositPage> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Installment Savings Deposit',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500
          )
        ),
        backgroundColor: CustomColor.jewel,
        bottom: TabBar(
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          unselectedLabelColor: Colors.white38,
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Total of Principal & Interest'),
            Tab(text: 'Amount of Installment'),
            Tab(text: 'No. of Installments'),
            Tab(text: 'Interest Rate for Installment Savings'),
          ]
        )
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          // CALCULATION OF TOTAL OF PRINCIPAL AND INTEREST
          TotalPrincipalAndInterestTab(),
          // CALCULATING AMOUNT OF INSTALLMENT
          AmountOfInstallmentTab(),
          // CALCULATE NUMBER OF INSTALLMENTS
          NumberOfInstallmentsTab(),
          // CALCULATING INTEREST RATE FOR INSTALLMENT SAVINGS
          InterestRateInstallmentSavingsTab(),
        ]
      ),
      floatingActionButton: fabExitButton(context)
    );
  }
}
