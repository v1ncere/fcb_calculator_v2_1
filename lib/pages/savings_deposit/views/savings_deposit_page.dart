import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/pages/savings_deposit/widgets/widgets.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class SavingsDepositPage extends StatefulWidget {
  const SavingsDepositPage({Key? key}) : super(key: key);
  @override
  State<SavingsDepositPage> createState() => _SavingsDeposit();
}

class _SavingsDeposit extends State<SavingsDepositPage> with TickerProviderStateMixin {
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
          'Savings Deposit Compounded',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500
          )
        ),
        backgroundColor: CustomColors.jewel,
        bottom: TabBar(
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          unselectedLabelColor: Colors.white38,
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Total of Principal & Interest'),
            Tab(text: 'Principal'),
            Tab(text: 'Interest Rate'),
            Tab(text: 'No. of Periods of Compound Interest'),
          ]
        )
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          /// CALCULATING THE TOTAL OF PRINCIPAL AND INTEREST
          TotalOfPrincipalAndInterestTab(),
          // CALCULATING PRINCIPAL
          PrincipalTab(),
          // CALCULATING INTEREST RATE
          InterestRateTab(),
          // CALCULATING NUMBER OF PERIODS OF COMPOUND INTEREST
          NumberPeriodsCompoundInterestTab(),
        ]
      ),
      floatingActionButton: fabExitButton(context)
    );
  }
}
