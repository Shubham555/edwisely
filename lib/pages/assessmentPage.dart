// Assessments screen that displays options to create and edit questions

// TODO: Change QuestionType enum from individual questions to the entire assessment level
// TODO: Reduce the insert image size for questions

import 'package:edwisely/models/assessment.dart';
import 'package:edwisely/models/question.dart';
import 'package:edwisely/models/questionType.dart';
import 'package:edwisely/widgets/assessment/assessmentPanel.dart';
import 'package:edwisely/widgets/assessment/gradientAppBar.dart';
import 'package:edwisely/widgets/assessment/previewTile.dart';
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
        flexibleSpace: GradientAppBar(
          title: widget.assessment.title,
          flatButton: FlatButton(
            child: Text(
              'Exit',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: null,
          ),
          borderButton: BorderButton(
            label: 'Done',
            onPressed: null,
            color: Colors.white,
          ),
        ),
      ),
      drawer: Drawer(),
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
                              index: q
                                  .key, //Displays the number of the question which is the key of the converted list
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
                          setState(() {
                            widget.assessment.questions.add(Question(
                                answers: null,
                                question: null,
                                rightAnswer: null,
                                type: null,
                                points: null));
                          });
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
                AssessmentPanel(
                  assessment: widget.assessment,
                  index: widget.indexer,
                  questionRefresher: questionRefresher,
                  typeRefresher: typeRefresher,
                  pointRefresher: pointRefresher,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
