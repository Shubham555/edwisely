import 'dart:developer';

import 'package:edwisely/models/assessment.dart';
import 'package:edwisely/swatches/gradients.dart';
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
                            fontSize: MediaQuery.of(context).size.width / 20,
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
      body: TabBarView(
        children: [
          Text('Objective Questions or i don\'t know'),
          Text('Subjective Questions or i don\'t know'),
          Text('Conducted Questions or i don\'t know'),
        ],
        controller: _assessmentPageTabController,
      ),
    );
  }

//<editor-fold desc="Bottom Sheet for Selecting Objective or Subjective">
  _showObjectiveSubjectiveSelectionModalBottomSheet(BuildContext context) =>
      showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hoverColor: Colors.red.shade200,
                  title: Text('Objective'),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AssessmentLandingPage())),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hoverColor: Colors.blue.shade200,
                  title: Text('Subjective'),
                  onTap: () =>
                      log('Assessment Page Bottom Sheet Subjective Clicked '),
                ),
              )
            ],
          ),
        ),
      );
//</editor-fold>
}
