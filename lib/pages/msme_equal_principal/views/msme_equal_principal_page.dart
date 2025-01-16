import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/pages/msme_equal_principal/widgets/widgets.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class MSMEEqualPrincipalPage extends StatefulWidget {
  const MSMEEqualPrincipalPage({super.key});
  
  @override
  State<MSMEEqualPrincipalPage> createState() => _MSMEEqualPrincipalState();
}

class _MSMEEqualPrincipalState extends State<MSMEEqualPrincipalPage> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'MSME Equal Principal',
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
          tabs: const <Widget>[
            Tab(text: 'Amortization Amount'),
            Tab(text: 'Loan Term'),
          ]
        )
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          // CALCULATING THE AMORTIZATION AMOUNT
          AmortizationAmountTab(),
          // CALCULATING LOAN TERM
          LoanTermTab(),
        ]
      ),
      floatingActionButton: fabExitButton(context)
    );
  }
}
