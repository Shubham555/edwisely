// Assessments screen that displays options to create and edit questions

import 'dart:developer';

import 'package:edwisely/models/assessment.dart';
import 'package:edwisely/models/question.dart';
import 'package:edwisely/models/questionType.dart';
import 'package:edwisely/swatches/gradients.dart';
import 'package:edwisely/widgets/assessment/gradientAppBar.dart';
import 'package:edwisely/widgets/assessment/previewTile.dart';
import 'package:edwisely/widgets/choiceTile.dart';
import 'package:edwisely/widgets/elements/borderButton.dart';
import 'package:flutter/material.dart';

class AssessmentPage extends StatefulWidget {
  int indexer = 0;
  Assessment assessment;

  AssessmentPage({@required this.assessment});

  @override
  _AssessmentPageState createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  //Remove and duplicate functions on Preview Tile widget

  TextEditingController _questionController = TextEditingController();
  TextEditingController _pointsController = TextEditingController();
  TextEditingController _choiceOneController = TextEditingController();
  TextEditingController _choiceTwoController = TextEditingController();
  TextEditingController _choiceThreeController = TextEditingController();
  TextEditingController _choiceFourController = TextEditingController();

  void remove(int index) {
    setState(() {
      widget.assessment.questions.removeAt(index);
      widget.indexer--;
    });
    print(widget.indexer);
  }

  void duplicate(int index) {
    setState(() {
      widget.assessment.questions
          .insert(index, widget.assessment.questions[index]);
      widget.indexer++;
    });
    print(widget.indexer);
  }

  //Invoker refreshes the index when a previewTile is pressed so as to display the appropriate question on the Question Edit Panel on the right
  void invoker(int index) {
    setState(() {
      widget.indexer = index;
    });
    print(widget.indexer);
  }

  //SetState functions of the Assessment Panel

  void questionRefresher(String text) {
    setState(() {
      widget.assessment.questions[widget.indexer].question = text;
    });
  }

  void pointRefresher(int points) {
    setState(() {
      widget.assessment.questions[widget.indexer].points = points;
    });
  }

  void typeRefresher(QuestionType type) {
    setState(() {
      widget.assessment.questions[widget.indexer].type = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
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
                height: MediaQuery.of(context).size.height / 3.5,
                decoration: BoxDecoration(gradient: Gradients.peacock),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 100),
                      child: Text(
                        'Create ${widget.assessment.type == QuestionType.Objective ? 'Objective' : 'Subjective'} Assessment',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width / 30,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height / 3.5),
        ),
        //</editor-fold>
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 5,
                  color: Colors.grey.withOpacity(0.5),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: widget.assessment.questions
                              .asMap()
                              .entries
                              .map((q) {
                            return PreviewTile(
                              index: q.key,
                              //Displays the number of the question which is the key of the converted list
                              type: q.value.type,
                              question: q.value.question,
                              delete: remove,
                              duplicate: duplicate,
                              invoker: invoker,
                            );
                          }).toList(), //The map function maps the questions list to the Powerpoint style preview tiles on the left on the assessment page
                        ),
                      ),

                      //Buttons on the bottom of the sidepanel for Add question, question bank and import Spreadsheet:
                      GestureDetector(
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Text(
                            'Add Question',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(
                            () {
                              widget.assessment.questions.add(Question(
                                  answers: null,
                                  question: _questionController.text,
                                  rightAnswer: null,
                                  type: null,
                                  points: int.parse(_pointsController.text)));
                            },
                          );
                        },
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Text(
                          'Question Bank',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Text(
                          'Import spreadsheet',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //The widget that takes care of the question editing features on the right side of the screen

                Container(
                  width: 4 * MediaQuery.of(context).size.width / 5,
                  color: Colors.grey.withOpacity(0.15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              offset: Offset.zero,
                              blurRadius: 1,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        margin: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        padding: EdgeInsets.all(30),
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: TextField(
                          controller: _questionController,
                          onChanged: (text) {
                            questionRefresher(text);
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Your question here',
                            hintStyle: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(20),
                                ),
                              ),
                              Container(
                                // color: Colors.blue,
                                width: MediaQuery.of(context).size.width / 5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.add_a_photo),
                                    ),
                                    Text(
                                      'Add photo',
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Text(
                                        'Points',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      height: 50,
                                      width: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        color: Colors.white,
                                      ),
                                      child: TextField(
                                        controller: _pointsController,
                                        onChanged: (text) {
                                          pointRefresher(int.parse(text));
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '10',
                                          hintStyle: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //Contains the answer widgets
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Wrap(
                          children: [
                            ChoiceTile(),
                            ChoiceTile(),
                            ChoiceTile(),
                            ChoiceTile(),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
