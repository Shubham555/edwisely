import 'dart:developer';

import 'package:edwisely/data/blocs/assessmentLandingScreen/conductdBloc/conducted_bloc.dart';
import 'package:edwisely/data/blocs/assessmentLandingScreen/objectiveBloc/objective_bloc.dart';
import 'package:edwisely/data/blocs/assessmentLandingScreen/subjectiveBloc/subjective_bloc.dart';
import 'package:edwisely/ui/screens/assessment/assessmentLandingScreen/conducted_tab.dart';
import 'package:edwisely/ui/screens/assessment/assessmentLandingScreen/objective_tab.dart';
import 'package:edwisely/ui/screens/assessment/assessmentLandingScreen/subjective_tab.dart';
import 'package:edwisely/ui/screens/assessment/createAssessment/create_assessment_screen.dart';
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
        flatButton: FlatButton(
          hoverColor: Color(0xFF1D2B64).withOpacity(.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(
              color: Color(0xFF1D2B64),
            ),
          ),
          onPressed: () => _showAlertDialog(context),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Create Assessment',
                style: TextStyle(
                  color: Color(0xFF1D2B64),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                color: Color(0xFF1D2B64),
              )
            ],
          ),
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

  _showAlertDialog(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Create a New Assignment',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 110),
                ),
                Divider(
                  thickness: 2,
                ),
                ListTile(
                  trailing: Icon(Icons.keyboard_arrow_right),
                  title: Text('Objective'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          CreateAssessmentScreen(),
                    ),
                  ),
                ),
                ListTile(
                  trailing: Icon(Icons.keyboard_arrow_right),
                  title: Text('Subjective'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          CreateAssessmentScreen(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
