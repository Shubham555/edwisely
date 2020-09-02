import 'dart:developer';

import 'package:edwisely/models/assessment.dart';
import 'package:edwisely/models/question.dart';
import 'package:edwisely/models/questionType.dart';
import 'package:edwisely/pages/assessmentPage.dart';
import 'package:edwisely/swatches/gradients.dart';
import 'package:edwisely/widgets/assessmentTile.dart';
import 'package:edwisely/widgets/datetile.dart';
import 'package:edwisely/widgets/snippetTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AssessmentLandingPage extends StatefulWidget {
  @override
  _AssessmentLandingPageState createState() => _AssessmentLandingPageState();
}

class _AssessmentLandingPageState extends State<AssessmentLandingPage>
    with SingleTickerProviderStateMixin {
  TabController _assessmentPageTabController;

  @override
  void initState() {
    _assessmentPageTabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        title: Text(
          'Logo here',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            onPressed: () =>
                log('AssessmentLandingPage AppBar actions Clicked'),
            child: Text('Details Here'),
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            onPressed: () =>
                log('AssessmentLandingPage AppBar actions Clicked'),
            child: Text('Details Here'),
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            onPressed: () =>
                log('AssessmentLandingPage AppBar actions Clicked'),
            child: Text('Details Here'),
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            onPressed: () =>
                log('AssessmentLandingPage AppBar actions Clicked'),
            child: Text('Details Here'),
          ),
        ],
        bottom: //<editor-fold desc="This Section Contains the TabBar and the Create Assessment Button">
            PreferredSize(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(gradient: Gradients.peacock),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 100),
                      child: Text(
                        'My Assessment',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width / 30,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              //<editor-fold desc="This Row Contains the Tab Bar and a Sized Box and the Create Assessment Button ">
              Row(
                children: [
                  TabBar(
                    labelPadding: EdgeInsets.symmetric(horizontal: 30),
                    indicatorColor: Colors.white,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    unselectedLabelStyle:
                        TextStyle(fontWeight: FontWeight.normal),
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    isScrollable: true,
                    controller: _assessmentPageTabController,
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
                  SizedBox(
                    width: 100,
                  ),
                  FlatButton(
                    hoverColor: Color(0xFF5E6BE7).withOpacity(.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: BorderSide(
                        color: Color(0xFF5E6BE7),
                      ),
                    ),
                    onPressed: () =>
                        _showObjectiveSubjectiveSelectionModalBottomSheet(
                            context),
                    child: Text(
                      'Create Assessment',
                      style: TextStyle(
                        color: Color(0xFF5E6BE7),
                      ),
                    ),
                  )
                ],
              )
//</editor-fold>
            ],
          ),
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height / 2.6),
        ),
        //</editor-fold>
      ),
      body: //<editor-fold desc="To be implemented the views">
          TabBarView(
        children: [
          ListView(
            children: [
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Objective Questions'),
                leading: Icon(Icons.question_answer),
              ),
            ],
          ),
          Column(
            children: [
              ListTile(
                title: Text('Subjective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Subjective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Subjective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Subjective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Subjective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Subjective Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Subjective Questions'),
                leading: Icon(Icons.question_answer),
              ),
            ],
          ),
          Column(
            children: [
              ListTile(
                title: Text('Conducted Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Conducted Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Conducted Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Conducted Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Conducted Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Conducted Questions'),
                leading: Icon(Icons.question_answer),
              ),
              ListTile(
                title: Text('Conducted Questions'),
                leading: Icon(Icons.question_answer),
              ),
            ],
          ),
        ],
        controller: _assessmentPageTabController,
      ),
      //</editor-fold>
    );
  }

//<editor-fold desc="Bottom Sheet for Selecting Objective or Subjective">
  _showObjectiveSubjectiveSelectionModalBottomSheet(BuildContext context) =>
      showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        useRootNavigator: false,
        context: context,
        builder: (context) => Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Create a new Assessment',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 50,
                    fontWeight: FontWeight.bold),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  trailing: Icon(Icons.keyboard_arrow_right),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hoverColor: Colors.red.shade200,
                  title: Text('Objective'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => AssessmentPage(
                        assessment: Assessment(
                          deadline: null,
                          description: 'Sample quiz',
                          duration: 200,
                          questions: [
                            Question(
                                answers: null,
                                question:
                                    'Who is the president of the United States',
                                rightAnswer: null,
                                type: QuestionType.Objective,
                                points: null)
                          ],
                          title: 'Sample quiz',
                          type: QuestionType.Objective,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  trailing: Icon(Icons.keyboard_arrow_right),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hoverColor: Colors.blue.shade200,
                  title: Text('Subjective'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => AssessmentPage(
                        assessment: Assessment(
                          deadline: null,
                          description: 'Sample quiz',
                          duration: 200,
                          questions: [
                            Question(
                                answers: null,
                                question:
                                    'Who is the president of the United States',
                                rightAnswer: null,
                                type: QuestionType.Subjective,
                                points: null)
                          ],
                          title: 'Sample quiz',
                          type: QuestionType.Subjective,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
//</editor-fold>
}
