import 'package:edwisely/ui/screens/assessment/assessmentLandingScreen/conductedTab/objective_tab.dart';
import 'package:edwisely/ui/screens/assessment/assessmentLandingScreen/conductedTab/subjective_tab.dart';
import 'package:flutter/material.dart';

class ConductedTab extends StatefulWidget {
  @override
  _ConductedTabState createState() => _ConductedTabState();
}

class _ConductedTabState extends State<ConductedTab>
    with TickerProviderStateMixin {
  TabController _objectiveOrSubjectiveTabController;

  @override
  void initState() {
    _objectiveOrSubjectiveTabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          labelPadding: EdgeInsets.symmetric(horizontal: 30),
          indicatorColor: Colors.white,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          isScrollable: true,
          controller: _objectiveOrSubjectiveTabController,
          tabs: [
            Tab(
              text: 'Objective',
            ),
            Tab(
              text: 'Subjective',
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _objectiveOrSubjectiveTabController,
            children: [
              ConductedTabObjectiveTab(),
              ConductedTabSubjectiveTab(),
            ],
          ),
        )
      ],
    );
  }
}
