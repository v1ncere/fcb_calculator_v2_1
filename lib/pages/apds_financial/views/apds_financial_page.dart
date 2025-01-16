
import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/pages/apds_financial/widgets/widgets.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class APDSFinancialPage extends StatefulWidget {
  const APDSFinancialPage({super.key});

  @override
  State<APDSFinancialPage> createState() => APDSFinancialState();
}

class APDSFinancialState extends State<APDSFinancialPage> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'APDS Financial',
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
            Tab(text: 'APDS Loan'),
            Tab(text: 'Amortization'),
            Tab(text: 'Loan Amount'),
          ]
        )
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          // CALCULATE APDS LOAN
          APDSLoanTab(),
          // AMORTIZATION
          AmortizationTab(),
          // CALCULATE BY LOAN AMOUNT
          LoanAmountTab(),
        ]
      ),
      floatingActionButton: fabExitButton(context)
    );
  }
}
