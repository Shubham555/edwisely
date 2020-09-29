/* no-op */
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/blocs/questionBank/questionBankSubjective/question_bank_subjective_bloc.dart';
import '../../../../data/cubits/objective_questions_cubit.dart';
import '../../../../data/cubits/topic_cubit.dart';
import '../../../../data/cubits/unit_cubit.dart';
import '../../../../data/model/questionBank/topicEntity/data.dart';
import '../../../../util/enums/question_type_enum.dart';
import '../../../widgets_util/big_app_bar_add_questions.dart';

class ChooseSubjectiveFromSelectedTab extends StatelessWidget {
  final String _title;
  final String _description;
  final int _subjectId;
  final QuestionType _questionType;
  final int _assessmentId;

  ChooseSubjectiveFromSelectedTab(this._title, this._description, this._subjectId, this._questionType, this._assessmentId);

  final _questionFetchCubit = QuestionsCubit();
  final topicCubit = TopicCubit();
  final SubjectiveBloc = QuestionBankSubjectiveBloc();
  final unitCubit = UnitCubit();

  @override
  Widget build(BuildContext context) {
    int topicId;
    int unitId;
    List<int> questions = [];
    return Scaffold(
      appBar: BigAppBarAddQuestionScreen(
        actions: [],
        appBarSize: MediaQuery.of(context).size.height / 5.2,
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
        titleText: 'Add Questions to ${_title} Assessment',
        description: "${_description}",
        subject: "Subject: ${_subjectId}",
      ).build(context),
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 6,
            height: MediaQuery.of(context).size.height,
            color: Colors.grey.shade500,
            child: BlocBuilder(
              cubit: _questionFetchCubit
                ..getQuestionsToAnAssessment(
                  _assessmentId,
                ),
              builder: (BuildContext context, state) {
                if (state is QuestionsToAnAssessmentFetched) {
                  return ListView.builder(
                    itemCount: state.assessmentQuestionsEntity.data.length,
                    itemBuilder: (BuildContext context, int index) => ListTile(
                      title: Text(
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
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Row(
                      children: [
                        RaisedButton(child: Text('Remember'), onPressed: () => SubjectiveBloc.add(GetUnitSubjectiveQuestionsByLevel(1, unitId))),
                        RaisedButton(child: Text('Understand'), onPressed: () => SubjectiveBloc.add(GetUnitSubjectiveQuestionsByLevel(2, unitId))),
                        RaisedButton(child: Text('Apply'), onPressed: () => SubjectiveBloc.add(GetUnitSubjectiveQuestionsByLevel(3, unitId))),
                        RaisedButton(child: Text('Analyze'), onPressed: () => SubjectiveBloc.add(GetUnitSubjectiveQuestionsByLevel(4, unitId))),
                      ],
                    ),
                    StatefulBuilder(
                      builder: (BuildContext context, void Function(void Function()) setState) {
                        return BlocBuilder(
                          cubit: SubjectiveBloc,
                          builder: (BuildContext context, state) {
                            if (state is UnitSubjectiveQuestionsFetched) {
                              return ListView.builder(
                                itemBuilder: (BuildContext context, int index) {
                                  return CheckboxListTile(
                                      value: questions.contains(state.questionBankSubjectiveEntity.data[index].id),
                                      onChanged: (flag) => flag
                                          ? questions.add(state.questionBankSubjectiveEntity.data[index].id)
                                          : questions.remove(state.questionBankSubjectiveEntity.data[index].id));
                                },
                              );
                            }
                            if (state is QuestionBankSubjectiveEmpty) {
                              return Text('No Questions');
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        );
                      },
                    )
                  ],
                )),
                Container(
                  width: MediaQuery.of(context).size.width / 6,
                  child: Column(
                    children: [
                      BlocBuilder(
                        cubit: unitCubit..getUnitsOfACourse(_subjectId),
                        builder: (BuildContext context, state) {
                          if (state is CourseUnitFetched) {
                            return StatefulBuilder(
                              builder: (BuildContext context, void Function(void Function()) setState) {
                                int enabledUnitId = state.units.data[0].id;
                                unitId = state.units.data[0].id;
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.units.data.length,
                                  itemBuilder: (BuildContext context, int index) => ListTile(
                                    hoverColor: Colors.white,
                                    selected: enabledUnitId == state.units.data[index].id,
                                    title: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          state.units.data[index].name,
                                          style: TextStyle(
                                              color: enabledUnitId == state.units.data[index].id ? Colors.black : Colors.grey.shade600,
                                              fontSize: enabledUnitId == state.units.data[index].id ? 25 : null),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      enabledUnitId = state.units.data[index].id;
                                      unitId = state.units.data[index].id;
                                      SubjectiveBloc.add(
                                        GetUnitSubjectiveQuestions(_subjectId, unitId),
                                      );
                                      setState(
                                        () {},
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          }
                          if (state is CourseUnitEmpty) {
                            return Text('No Units to fetch');
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      BlocBuilder(
                        cubit: topicCubit..getTopics(_subjectId),
                        builder: (BuildContext context, state) {
                          if (state is TopicFetched) {
                            return ChipsChoice<int>.single(
                              value: topicId,
                              options: ChipsChoiceOption.listFrom(
                                source: state.topicEntity.data,
                                value: (i, Data v) => v.id,
                                label: (i, Data v) => v.name,
                              ),
                              onChanged: (int value) => SubjectiveBloc.add(
                                GetUnitSubjectiveQuestionsByTopic(value, unitId),
                              ),
                            );
                          }
                          if (state is TopicEmpty) {
                            return Text('No topcis to Tag');
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      RaisedButton.icon(
                        onPressed: () => questions.isEmpty ? null : null,
                        icon: Icon(Icons.add),
                        label: Text('Add'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
