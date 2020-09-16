import 'package:edwisely/data/blocs/questionBank/questionBankObjective/question_bank_objective_bloc.dart';
import 'package:edwisely/data/blocs/questionBank/question_bank_bloc.dart';
import 'package:edwisely/data/cubits/unit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'course_details_objective_part.dart';

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
  int bookmarkRadio = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 12,
          child: Expanded(
            child: BlocBuilder(
              cubit: context.bloc<UnitCubit>(),
              builder: (BuildContext context, state) {
                if (state is CourseUnitFetched) {
                  context.bloc<QuestionBankObjectiveBloc>().add(
                        GetUnitObjectiveQuestions(
                          widget.subjectId,
                          state.units.data[0].id,
                        ),
                      );

                  return ListView.builder(
                    itemCount: state.units.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(
                          state.units.data[index].name,
                        ),
                        onTap: () => context.bloc<QuestionBankBloc>().add(
                              GetUnitQuestions(
                                widget.subjectId,
                                state.units.data[index].id,
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
          ),
        ),
        Expanded(
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
                                            child: Text('No Level'),
                                            value: -1,
                                          ),
                                          DropdownMenuItem(
                                            child: Text('Level 1'),
                                            value: 1,
                                          ),
                                          DropdownMenuItem(
                                            child: Text('Level 2'),
                                            value: 2,
                                          ),
                                          DropdownMenuItem(
                                            child: Text('Level 3'),
                                            value: 3,
                                          ),
                                          DropdownMenuItem(
                                            child: Text('Level 4'),
                                            value: 4,
                                          ),
                                          DropdownMenuItem(
                                            child: Text('Level 5'),
                                            value: 5,
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
                                                  .bloc<QuestionBankBloc>()
                                                  .add(
                                                    GetUnitQuestions(
                                                      widget.subjectId,
                                                      state.unitId,
                                                    ),
                                                  )
                                              : context
                                                  .bloc<QuestionBankBloc>()
                                                  .add(
                                                    GetUnitQuestionsByLevel(
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
                                                .bloc<QuestionBankBloc>()
                                                .add(
                                                  GetUnitQuestions(
                                                    widget.subjectId,
                                                    state.unitId,
                                                  ),
                                                )
                                            : context
                                                .bloc<QuestionBankBloc>()
                                                .add(
                                                  GetUnitQuestionsByTopic(
                                                    value,
                                                    state.unitId,
                                                  ),
                                                );
                                      },
                                    ),
                                    Container(
                                      child: RadioListTile(
                                        title: Text('All Questions'),
                                        value: 0,
                                        groupValue: bookmarkRadio,
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              bookmarkRadio = value;
                                            },
                                          );
                                          context.bloc<QuestionBankBloc>().add(
                                                GetUnitQuestions(
                                                  widget.subjectId,
                                                  state.unitId,
                                                ),
                                              );
                                        },
                                      ),
                                      width: 170,
                                      height: 50,
                                    ),
                                    Container(
                                      child: RadioListTile(
                                        title: Text('Bookmarked'),
                                        value: 1,
                                        groupValue: bookmarkRadio,
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              bookmarkRadio = value;
                                            },
                                          );
                                          context.bloc<QuestionBankBloc>().add(
                                                GetQuestionsByBookmark(
                                                  state.unitId,
                                                ),
                                              );
                                        },
                                      ),
                                      width: 200,
                                      height: 50,
                                    ),
                                    Container(
                                      child: RadioListTile(
                                        title: Text('Your Questions'),
                                        value: 2,
                                        groupValue: bookmarkRadio,
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              bookmarkRadio = value;
                                            },
                                          );
                                          context.bloc<QuestionBankBloc>().add(
                                                GetYourQuestions(
                                                  state.unitId,
                                                ),
                                              );
                                        },
                                      ),
                                      width: 200,
                                      height: 50,
                                    ),
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      (3.5 / 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Subjective Questions',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              50,
                                        ),
                                      ),
                                      FlatButton(
                                        hoverColor:
                                            Color(0xFF1D2B64).withOpacity(.2),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
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
                                ),
                                BlocProvider.value(
                                  value:
                                      context.bloc<QuestionBankObjectiveBloc>(),
                                  child: CourseDetailsObjectivePart(),
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
                                        'View More',
                                        style: TextStyle(
                                          color: Color(0xFF1D2B64),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 3,
                              color: Colors.grey,
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
        ),
      ],
    );
  }
}
