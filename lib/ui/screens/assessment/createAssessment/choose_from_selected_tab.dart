import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:edwisely/ui/widgets_util/big_app_bar_add_questions.dart';
import 'package:edwisely/util/enums/question_type_enum.dart';

class ChooseFromSelectedTab extends StatefulWidget {
  final String _title;
  final String _description;
  final int _subjectId;
  final QuestionType _questionType;
  final int _assessmentId;
  ChooseFromSelectedTab(
    this._title,
    this._description,
    this._subjectId,
    this._questionType,
    this._assessmentId,
  );

  @override
  _ChooseFromSelectedTabState createState() => _ChooseFromSelectedTabState();
}

class _ChooseFromSelectedTabState extends State<ChooseFromSelectedTab> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: BigAppBarAddQuestionScreen(
          actions: [],
          appBarSize: height / 5.2,
          appBarTitle: Text(
            'Edwisely',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          flatButton: FlatButton(
            onPressed: () => null,
            child: Text('Save'),
          ),
          titleText: 'Type Questions to ${widget._title} Assessment',
          description: "${widget._description}",
          subject: "Subject: ${widget._subjectId}",
        ).build(context),
        backgroundColor: Color(0xffE5E5E5),
        body: Column(
          children: [
            Row(
              children: [
                ColumnLeft(height, width),
                ColumnCenter(height, width),
                ColumnRight(height, width),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ColumnRight extends StatelessWidget {
  ColumnRight(this.height, this.width);
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height * 0.2,
          width: width * 0.2,
          child: GridView.builder(
            itemCount: 5,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) => FlatButton(
              onPressed: null,
              child: Text("$index"),
            ),
          ),
        ),
      ],
    );
  }
}

class ColumnCenter extends StatelessWidget {
  ColumnCenter(this.height, this.width);
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.02),
      child: Expanded(
        child: Container(
          color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Choose From existing'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: null,
                    child: Text("Remember"),
                  ),
                  RaisedButton(
                    onPressed: null,
                    child: Text("Understand"),
                  ),
                  RaisedButton(
                    onPressed: null,
                    child: Text("Apply"),
                  ),
                  RaisedButton(
                    onPressed: null,
                    child: Text("Analyze"),
                  ),
                ],
              ),
              QuestionCard(),
              QuestionCard(),
              QuestionCard(),
              QuestionCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class ColumnLeft extends StatelessWidget {
  const ColumnLeft(this.height, this.width);
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: 100,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) => QuestionTab("Q$index"),
          ),
        ),
      ],
    );
  }
}

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Card(
          child: Column(
            children: [
              Text('Question'),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                softWrap: true,
              ),
              Text("Correct Answer"),
            ],
          ),
        ),
        Checkbox(value: false, onChanged: null),
      ],
    );
  }
}

class QuestionTab extends StatelessWidget {
  const QuestionTab(this.ques);
  final String ques;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      child: FlatButton(
        onPressed: null,
        child: Text(ques),
      ),
    );
  }
}
