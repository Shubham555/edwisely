import 'package:edwisely/data/blocs/addQuestionScreen/add_question_bloc.dart';
import 'package:edwisely/ui/screens/assessment/createAssessment/upload_excel_tab.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:edwisely/ui/widgets_util/big_app_bar_add_questions.dart';
import 'package:edwisely/util/enums/question_type_enum.dart';
import 'choose_ques_elements/choose_ques_left_column.dart';
import 'choose_ques_elements/choose_ques_right_column.dart';
import 'choose_ques_elements/choose_ques_center_column.dart';

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
