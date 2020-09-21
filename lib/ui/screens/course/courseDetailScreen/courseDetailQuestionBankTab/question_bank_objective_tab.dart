import 'package:catex/catex.dart';
import 'package:edwisely/data/blocs/questionBank/questionBankObjective/question_bank_objective_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionBankObjectiveTab extends StatefulWidget {
  final int subjectId;

  QuestionBankObjectiveTab(this.subjectId);

  @override
  _QuestionBankObjectiveTabState createState() =>
      _QuestionBankObjectiveTabState();
}

class _QuestionBankObjectiveTabState extends State<QuestionBankObjectiveTab> {
  int levelDropDownValue = -1;
  int topicsDropDown = 1234567890;
  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder(
        cubit: context.bloc<QuestionBankObjectiveBloc>(),
        builder: (BuildContext context, state) {
          if (state is UnitObjectiveQuestionsFetched) {
            return Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: ListView(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                DropdownButton(
                                    items: [
                                      DropdownMenuItem(
                                        child: Text('All'),
                                        value: -1,
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Remember'),
                                        value: 1,
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Understand'),
                                        value: 2,
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Apply'),
                                        value: 3,
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Analyze'),
                                        value: 4,
                                      ),
                                    ],
                                    value: levelDropDownValue,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          levelDropDownValue = value;
                                        },
                                      );
                                      value == -1
                                          ? context
                                              .bloc<QuestionBankObjectiveBloc>()
                                              .add(
                                                GetUnitObjectiveQuestions(
                                                  widget.subjectId,
                                                  state.unitId,
                                                ),
                                              )
                                          : context
                                              .bloc<QuestionBankObjectiveBloc>()
                                              .add(
                                                GetUnitObjectiveQuestionsByLevel(
                                                  value,
                                                  state.unitId,
                                                ),
                                              );
                                    }),
                                DropdownButton(
                                  items: state.dropDownList,
                                  value: topicsDropDown,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        topicsDropDown = value;
                                      },
                                    );
                                    value == 1234567890
                                        ? context
                                            .bloc<QuestionBankObjectiveBloc>()
                                            .add(
                                              GetUnitObjectiveQuestions(
                                                widget.subjectId,
                                                state.unitId,
                                              ),
                                            )
                                        : context
                                            .bloc<QuestionBankObjectiveBloc>()
                                            .add(
                                              GetUnitObjectiveQuestionsByTopic(
                                                value,
                                                state.unitId,
                                              ),
                                            );
                                  },
                                ),
                                Row(
                                  children: [
                                    Container(
                                      child: FlatButton(
                                        onPressed: () {
                                          setState(() {
                                            isSelected = 0;
                                          });
                                          context
                                              .bloc<QuestionBankObjectiveBloc>()
                                              .add(
                                                GetUnitObjectiveQuestions(
                                                  widget.subjectId,
                                                  state.unitId,
                                                ),
                                              );
                                        },
                                        child: Text(
                                          'All Questions',
                                          style: TextStyle(
                                              fontWeight: isSelected == 0
                                                  ? FontWeight.bold
                                                  : null),
                                        ),
                                      ),
                                      width: 170,
                                      height: 50,
                                    ),
                                    Container(
                                      child: FlatButton(
                                        onPressed: () {
                                          setState(() {
                                            isSelected = 1;
                                          });
                                          context
                                              .bloc<QuestionBankObjectiveBloc>()
                                              .add(
                                                GetObjectiveQuestionsByBookmark(
                                                  state.unitId,
                                                ),
                                              );
                                        },
                                        child: Text(
                                          'Bookmarked',
                                          style: TextStyle(
                                              fontWeight: isSelected == 1
                                                  ? FontWeight.bold
                                                  : null),
                                        ),
                                      ),
                                      width: 200,
                                      height: 50,
                                    ),
                                    Container(
                                      child: FlatButton(
                                        onPressed: () {
                                          setState(() {
                                            isSelected = 2;
                                          });
                                          context
                                              .bloc<QuestionBankObjectiveBloc>()
                                              .add(
                                                GetYourObjectiveQuestions(
                                                  state.unitId,
                                                ),
                                              );
                                        },
                                        child: Text(
                                          'Your Questions',
                                          style: TextStyle(
                                              fontWeight: isSelected == 2
                                                  ? FontWeight.bold
                                                  : null),
                                        ),
                                      ),
                                      width: 200,
                                      height: 50,
                                    ),
                                  ],
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Objective Questions',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.height / 50,
                                  ),
                                ),
                                FlatButton(
                                  hoverColor: Color(0xFF1D2B64).withOpacity(.2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    side: BorderSide(
                                      color: Color(0xFF1D2B64),
                                    ),
                                  ),
                                  onPressed: () => null,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Color(0xFF1D2B64),
                                      ),
                                      Text(
                                        'Add Your Questions',
                                        style: TextStyle(
                                          color: Color(0xFF1D2B64),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            BlocBuilder(
                              cubit: context.bloc<QuestionBankObjectiveBloc>(),
                              builder: (BuildContext context, state) {
                                if (state is UnitObjectiveQuestionsFetched) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state.questionBankObjectiveEntity
                                        .data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                          print(state
                                              .questionBankObjectiveEntity
                                              .data[0]
                                              .name);
                                      return Card(
                                      margin: EdgeInsets.all(
                                        10,
                                      ),
                                      child: ListTile(
                                        title: Row(
                                          children: [
                                            Text('Q. ${index + 1}  '),
                                            Expanded(
                                              child: CaTeX(
                                                state
                                                    .questionBankObjectiveEntity
                                                    .data[index]
                                                    .name,
                                              ),
                                            ),
                                          ],
                                        ),
                                        subtitle: Text(
                                          'Level ${state.questionBankObjectiveEntity.data[index].blooms_level}',
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(Icons.bookmark),
                                          onPressed: null,
                                        ),
                                      ),
                                    );
                                        },
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
