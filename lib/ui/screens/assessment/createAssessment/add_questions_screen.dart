import 'package:catex/catex.dart';
import 'package:edwisely/data/blocs/addQuestionScreen/add_question_bloc.dart';
import 'package:edwisely/data/cubits/objective_questions_cubit.dart';
import 'package:edwisely/data/cubits/topic_cubit.dart';
import 'package:edwisely/ui/screens/assessment/createAssessment/choose_objective_from_selected_tab.dart';
import 'package:edwisely/ui/screens/assessment/createAssessment/choose_subjective_from_selected_tab.dart';
import 'package:edwisely/ui/screens/assessment/createAssessment/type_question_tab.dart';
import 'package:edwisely/ui/widgets_util/big_app_bar.dart';
import 'package:edwisely/util/enums/question_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/blocs/addQuestionScreen/add_question_bloc.dart';

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
  final _questionFetchCubit = QuestionsCubit();
  Size screenSize;
  TextTheme textTheme;

  bool _isSideDrawerCollapsed = true;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    textTheme = Theme.of(context).textTheme;
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
          // NavigationDrawer(),
          Container(
            width: MediaQuery.of(context).size.width / 6,
            height: MediaQuery.of(context).size.height,
            color: Colors.grey.shade500,
            child: BlocBuilder(
              cubit: _questionFetchCubit
                ..getQuestionsToAnAssessment(
                  widget._assessmentId,
                ),
              builder: (BuildContext context, state) {
                if (state is QuestionsToAnAssessmentFetched) {
                  return ListView.builder(
                    itemCount: state.assessmentQuestionsEntity.data.length,
                    itemBuilder: (BuildContext context, int index) => ListTile(
                      title: CaTeX(
                        state.assessmentQuestionsEntity.data[index].name,
                      ),
                    ),
                  );
                }
                if (state is QuestionsToAnAssessmentEmpty) {
                  return Center(
                    child: Text('Add Questions to this Assessment'),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Text(
                  'Create Questions',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height / 40,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Visibility(
                      child: Container(
                        width: 150,
                        height: 150,
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (BuildContext context) =>
                                        AddQuestionBloc(),
                                  ),
                                  BlocProvider(
                                    create: (BuildContext context) =>
                                        TopicCubit(),
                                  ),
                                ],
                                child: TypeQuestionTab(
                                    widget._title,
                                    widget._description,
                                    widget._subjectId,
                                    widget._questionType,
                                    widget._assessmentId),
                              ),
                            ),
                          ),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_circle_outline,
                                    size: 45,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text('Add Questions')
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      visible: widget._questionType == QuestionType.Objective,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.upload_file,
                                size: 45,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text('Upload Questions')
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      child: Container(
                        width: 150,
                        height: 150,
                        child: Container(
                          width: 150,
                          height: 150,
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => BlocProvider(
                                  create: (BuildContext context) =>
                                      AddQuestionBloc(),
                                  child: ChooseObjectiveFromSelectedTab(
                                      widget._title,
                                      widget._description,
                                      widget._subjectId,
                                      widget._questionType,
                                      widget._assessmentId),
                                ),
                              ),
                            ),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.handyman,
                                      size: 45,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text('Choose from Question Bank')
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      visible: widget._questionType == QuestionType.Objective,
                    ),
                    Visibility(
                      child: Container(
                        width: 150,
                        height: 150,
                        child: Container(
                          width: 150,
                          height: 150,
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => BlocProvider(
                                  create: (BuildContext context) =>
                                      AddQuestionBloc(),
                                  child: ChooseSubjectiveFromSelectedTab(
                                    widget._title,
                                    widget._description,
                                    widget._subjectId,
                                    widget._questionType,
                                    widget._assessmentId,
                                  ),
                                ),
                              ),
                            ),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.handyman,
                                      size: 45,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text('Choose from Question Bank')
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      visible: widget._questionType == QuestionType.Subjective,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
