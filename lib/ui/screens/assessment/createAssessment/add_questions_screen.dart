import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../data/cubits/objective_questions_cubit.dart';
import '../../../../data/provider/selected_page.dart';
import '../../../../util/enums/question_type_enum.dart';
import '../../../widgets_util/big_app_bar.dart';
import '../../../widgets_util/navigation_drawer.dart';
import '../sendAssessment/send_assessment_screen.dart';
import 'choose_objective_from_selected_tab.dart';
import 'choose_subjective_from_selected_tab.dart';
import 'type_question_tab.dart';

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

class _AddQuestionsScreenState extends State<AddQuestionsScreen> with SingleTickerProviderStateMixin {
  final _questionFetchCubit = QuestionsCubit();
  Size screenSize;
  TextTheme textTheme;
  List<int> questions = [];

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Row(
        children: [
          NavigationDrawer(
            isCollapsed: true,
            key: context.watch<SelectedPageProvider>().navigatorKey,
          ),
          Expanded(
            child: Column(
              children: [
                BigAppBar(
                  actions: [],
                  bottomTab: null,
                  appBarSize: MediaQuery.of(context).size.height * 0.3,
                  appBarTitle: Text(
                    'Edwisely',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  route: '',
                  flatButton: FlatButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) => SendAssessmentScreen(widget._assessmentId, widget._title,widget._description))),
                    child: Text('Save'),
                  ),
                  titleText: 'Add Questions to ${widget._title} Assessment',
                ).build(context),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 6,
                      height: MediaQuery.of(context).size.height * 0.7,
                      color: Colors.grey.shade500,
                      child: BlocBuilder(
                        cubit: _questionFetchCubit
                          ..getQuestionsToAnAssessment(
                            widget._assessmentId,
                          ),
                        builder: (BuildContext context, state) {
                          if (state is QuestionsToAnAssessmentFetched) {
                            state.assessmentQuestionsEntity.data.forEach((element) {
                              questions.add(element.id);
                            });
                            return ListView.builder(
                              itemCount: state.assessmentQuestionsEntity.data.length,
                              itemBuilder: (BuildContext context, int index) => Card(
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Text('Q ${index + 1}   '),
                                      Expanded(
                                        child: Text(
                                          state.assessmentQuestionsEntity.data[index].name,
                                          // overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
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
                                        builder: (BuildContext context) => TypeQuestionTab(
                                            widget._title, widget._description, widget._subjectId, widget._questionType, widget._assessmentId,false),
                                      ),
                                    ).then((value) => _questionFetchCubit.getQuestionsToAnAssessment(widget._assessmentId)),
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
                                          builder: (BuildContext context) => ChooseObjectiveFromSelectedTab(
                                              widget._title, widget._description, widget._subjectId, widget._questionType, widget._assessmentId),
                                        ),
                                      ).then((value) => _questionFetchCubit.getQuestionsToAnAssessment(widget._assessmentId)),
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
                                          builder: (BuildContext context) => ChooseSubjectiveFromSelectedTab(
                                            widget._title,
                                            widget._description,
                                            widget._subjectId,
                                            widget._questionType,
                                            widget._assessmentId,
                                          ),
                                        ),
                                      ).then((value) => _questionFetchCubit.getQuestionsToAnAssessment(widget._assessmentId)),
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
