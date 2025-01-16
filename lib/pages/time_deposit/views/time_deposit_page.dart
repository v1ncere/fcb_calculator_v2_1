import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/pages/time_deposit/widgets/widgets.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class TimeDepositPage extends StatefulWidget {
  const TimeDepositPage({super.key});
  
  @override
  State<TimeDepositPage> createState() => _TimeDeposit();
}

class _TimeDeposit extends State<TimeDepositPage> with TickerProviderStateMixin {
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
          'Time Deposit Not Compounded',
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
            Tab(text: 'Total of Principal & Interest'),
            Tab(text: 'Principal'),
            Tab(text: 'Interest Rate'),
            Tab(text: 'Term/Years'),
          ]
        )
      ),
      // TAB BAR BODY
      body: TabBarView(
        controller: _tabController,
        children: const [
          // CALCULATING THE TOTAL OF PRINCIPAL AND INTEREST
          TotalPrincipalInterestTab(),
          // CALCULATING PRINCIPAL
          PrincipalTab(),
          // CALCULATING INTEREST RATE
          InterestRateTab(),
          // CALCULATING THE TERM
          TermYearsTab(),
        ]
      ),
      floatingActionButton: fabExitButton(context)
    );
  }
}
