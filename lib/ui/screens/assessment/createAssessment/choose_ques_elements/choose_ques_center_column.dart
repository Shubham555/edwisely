import 'package:edwisely/data/blocs/addQuestionScreen/add_question_bloc.dart';
import 'package:edwisely/ui/screens/assessment/createAssessment/upload_excel_tab.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:edwisely/ui/widgets_util/big_app_bar_add_questions.dart';
import 'package:edwisely/util/enums/question_type_enum.dart';

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
