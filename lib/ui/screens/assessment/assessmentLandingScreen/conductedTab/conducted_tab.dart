import 'package:flutter/material.dart';

import 'objective_tab.dart';
import 'subjective_tab.dart';

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
        SizedBox(height: 32.0),
        TabBar(
          labelPadding: EdgeInsets.symmetric(horizontal: 36.0),
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          indicatorPadding: const EdgeInsets.only(top: 8.0),
          unselectedLabelColor: Colors.grey,
          unselectedLabelStyle: Theme.of(context).textTheme.headline6,
          labelStyle: Theme.of(context).textTheme.headline5.copyWith(
                fontWeight: FontWeight.bold,
              ),
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
        SizedBox(height: 32.0),
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
