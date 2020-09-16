import 'package:edwisely/data/blocs/addQuestionScreen/add_question_bloc.dart';
import 'package:edwisely/ui/screens/assessment/createAssessment/upload_excel_tab.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:edwisely/ui/widgets_util/big_app_bar_add_questions.dart';
import 'package:edwisely/util/enums/question_type_enum.dart';

class ChooseFromSelectedTab extends StatefulWidget {
  final String _title;
  final String _description;
  final int _subjectId;
  final QuestionType _questionType;
  final int _assessmentId;
  int quesCounter = 0;
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
        backgroundColor: Colors.white,
        body: Row(
          children: [
            ColumnLeft(height, width, widget.quesCounter),
            ColumnCenter(height, width),
            ColumnRight(height, width),
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
    return Container(
      color: Colors.white,
      width: width * 0.17,
      padding: EdgeInsets.only(right: width * 0.03, top: height * 0.03),
      child: Column(
        children: [
          Container(
              height: height * 0.2,
              width: width * 0.10,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.all(height * 0.01),
                  height: 17,
                  child: MaterialButton(
                    color: Colors.white,
                    onPressed: () {},
                    child: Text("Unit${index + 1}"),
                  ),
                ),
              )),
          SizedBox(
            height: height * 0.02,
          ),
          Text('Topics'),
          Container(
            height: height * 0.26,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) => _buildTopicsList(index)),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          RaisedButton(
            onPressed: () {},
            child: Text("Add"),
          )
        ],
      ),
    );
  }
}

_buildTopicsList(int index) {
  return Container(
    height: 25,
    width: 50,
    child: CheckboxListTile(
      title: Text("Title ${index + 1}"),
      value: false,
      onChanged: (value) => {},
    ),
  );
}

class ColumnCenter extends StatelessWidget {
  ColumnCenter(this.height, this.width);
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(
            width * 0.04, height * 0.02, width * 0.02, height * 0.02),
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
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              height: height * 0.52,
              child: ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => _buildQuestionBody(context)),
            )
          ],
        ),
      ),
    );
  }
}

_buildQuestionBody(BuildContext context) {
  return QuestionCard(context);
}

class ColumnLeft extends StatelessWidget {
  const ColumnLeft(this.height, this.width, this.quesCount);
  final double width;
  final double height;
  final int quesCount;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.1,
      color: Color(0xffE5E5E5),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView.builder(
                itemCount: quesCount,
                itemBuilder: (context, index) => _buildlist(index)),
          ),
          FlatButton(
            onPressed: null,
            child: Text("Type Question"),
          ),
          FlatButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => BlocProvider(
                  create: (BuildContext context) => AddQuestionBloc(),
                  child: UploadExcelTab(),
                ),
              ),
            ),
            child: Text("Upload Question"),
          ),
          FlatButton(
            onPressed: null,
            child: Text("Choose"),
          ),
        ],
      ),
    );
  }
}

_buildlist(index) {
  return ListTile(
    title: Text("Question${index + 1}"),
  );
}

class QuestionCard extends StatefulWidget {
  QuestionCard(BuildContext context);

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          width: width * 0.6,
          child: Card(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02, vertical: height * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question',
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    softWrap: true,
                  ),
                  Text("Correct Answer"),
                ],
              ),
            ),
          ),
        ),
        Checkbox(value: false, onChanged: (value) {}),
      ],
    );
  }
}

class QuestionTab extends StatelessWidget {
  const QuestionTab(this.ques);
  final String ques;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.05,
      child: FlatButton(
        onPressed: null,
        child: Text(ques),
      ),
    );
  }
}
