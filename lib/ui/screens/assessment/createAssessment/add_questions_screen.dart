import 'package:edwisely/data/blocs/assessmentLandingScreen/addQuestionScreen/add_question_bloc.dart';
import 'package:edwisely/ui/screens/assessment/createAssessment/choose_from_selected_tab.dart';
import 'package:edwisely/ui/screens/assessment/createAssessment/type_question_tab.dart';
import 'package:edwisely/ui/widgets_util/big_app_bar.dart';
import 'package:edwisely/util/enums/question_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddQuestionsScreen extends StatefulWidget {
  final String _title;
  final String _description;
  final int _subjectId;
  final QuestionType _questionType;
  final int _assessmentId;

  AddQuestionsScreen(
    this._title,
    this._description,
    this._subjectId,
    this._questionType,
    this._assessmentId,
  );

  @override
  _AddQuestionsScreenState createState() => _AddQuestionsScreenState();
}

class _AddQuestionsScreenState extends State<AddQuestionsScreen>
    with SingleTickerProviderStateMixin {
  TabController _questionController;

  @override
  void initState() {
    _questionController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BigAppBar(
        actions: [],
        bottomTab: null,
        appBarSize: MediaQuery.of(context).size.height / 3.5,
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
        titleText: 'Add Questions to ${widget._title} Assessment',
      ).build(context),
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 5,
            color: Colors.grey.withOpacity(.5),
          ),
          Expanded(
            child: Column(
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
                  controller: _questionController,
                  tabs: [
                    Tab(
                      text: 'Type Question',
                    ),
                    Tab(
                      text: 'Upload Question',
                    ),
                    Tab(
                      text: 'Choose from Existing',
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _questionController,
                    children: [
                      BlocProvider(
                        create: (BuildContext context) => AddQuestionBloc(),
                        child: TypeQuestionTab(),
                      ),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FlatButton(
                              onPressed: null,
                              child: Text('Excel Template Download'),
                            ),
                            FlatButton(
                              onPressed: null,
                              child: Text('Upload Template'),
                            ),
                          ],
                        ),
                      ),
                      BlocProvider(
                        create: (BuildContext context) => AddQuestionBloc(),
                        child: ChooseFromSelectedTab(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
