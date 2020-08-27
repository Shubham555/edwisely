import 'package:edwisely/models/assessment.dart';
import 'package:edwisely/models/question.dart';
import 'package:edwisely/widgets/choiceTile.dart';
import 'package:flutter/material.dart';

class AssessmentPanel extends StatefulWidget {
  Assessment assessment;
  int index;
  AssessmentPanel({@required this.assessment, @required this.index});

  @override
  _AssessmentPanelState createState() => _AssessmentPanelState();
}

class _AssessmentPanelState extends State<AssessmentPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              onChanged: (text) {
                setState(() {
                  widget.assessment.questions[widget.index].question = text;
                  print(widget.assessment.questions[widget.index].question);
                });
              },
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                      )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo),
                          Text(
                            'Add photo',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    // color: Colors.blue,
                    width: MediaQuery.of(context).size.width / 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.white,
                          ),
                          child: Text(
                            '60',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'Answer Options',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 50,
                          width: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.white,
                          ),
                          child: Text(
                            'Single Select',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
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
    );
  }
}
