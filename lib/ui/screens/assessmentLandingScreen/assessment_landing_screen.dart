import 'package:edwisely/data/blocs/assessmentLandingScreen/conductdBloc/conducted_bloc.dart';
import 'package:edwisely/data/blocs/assessmentLandingScreen/objectiveBloc/objective_bloc.dart';
import 'package:edwisely/data/blocs/assessmentLandingScreen/subjectiveBloc/subjective_bloc.dart';
import 'package:edwisely/ui/screens/assessmentLandingScreen/conducted_tab.dart';
import 'package:edwisely/ui/screens/assessmentLandingScreen/objective_tab.dart';
import 'package:edwisely/ui/screens/assessmentLandingScreen/subjective_tab.dart';
import 'package:edwisely/ui/widgets_util/big_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssessmentLandingScreen extends StatefulWidget {
  @override
  _AssessmentLandingScreenState createState() =>
      _AssessmentLandingScreenState();
}

class _AssessmentLandingScreenState extends State<AssessmentLandingScreen>
    with SingleTickerProviderStateMixin {
  TabController _assessmentLandingScreenTabController;

  @override
  void initState() {
    _assessmentLandingScreenTabController =
        TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BigAppBar(
        actions: [],
        titleText: 'My Assessments',
        bottomTab: TabBar(
          labelPadding: EdgeInsets.symmetric(horizontal: 30),
          indicatorColor: Colors.white,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          isScrollable: true,
          controller: _assessmentLandingScreenTabController,
          tabs: [
            Tab(
              text: 'Objective',
            ),
            Tab(
              text: 'Subjective',
            ),
            Tab(
              text: 'Conducted',
            ),
          ],
        ),
        appBarSize: MediaQuery.of(context).size.height / 3,
        appBarTitle: Text(
          'Edwisely',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ).build(context),
      body: TabBarView(
        controller: _assessmentLandingScreenTabController,
        children: [
          BlocProvider(
            create: (BuildContext context) => ObjectiveBloc()
              ..add(
                GetObjectiveTests(),
              ),
            child: ObjectiveTab(),
          ),
          BlocProvider(
            create: (BuildContext context) => SubjectiveBloc()
              ..add(
                GetSubjectiveTests(),
              ),
            child: SubjectiveTab(),
          ),
          BlocProvider(
            create: (BuildContext context) => ConductedBloc(),
            child: ConductedTab(),
          ),
        ],
      ),
    );
  }
}
