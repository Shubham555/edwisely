import 'package:edwisely/data/blocs/questionBank/question_bank_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionBankAllTab extends StatefulWidget {
  final int subjectId;
  final TabController _tabController;

  QuestionBankAllTab(this.subjectId, this._tabController);

  @override
  _QuestionBankAllTabState createState() => _QuestionBankAllTabState();
}

class _QuestionBankAllTabState extends State<QuestionBankAllTab> {
  int levelDropDownValue = -1;
  int topicsDropDown = 1234567890;
  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder(
        cubit: context.bloc<QuestionBankBloc>(),
        builder: (BuildContext context, state) {
          if (state is UnitQuestionsFetched) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: ListView(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 16.0,
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Level'),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4.0,
                                          horizontal: 12.0,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: DropdownButton(
                                          underline: SizedBox.shrink(),
                                          isExpanded: true,
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
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 32.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Topic'),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4.0,
                                          horizontal: 12.0,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: DropdownButton(
                                          items: state.dropDownList,
                                          value: topicsDropDown,
                                          underline: SizedBox.shrink(),
                                          isExpanded: true,
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
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Container(
                                        child: FlatButton(
                                          onPressed: () {
                                            setState(() {
                                              isSelected = 0;
                                            });
                                            context
                                                .bloc<QuestionBankBloc>()
                                                .add(
                                                  GetUnitQuestions(
                                                    widget.subjectId,
                                                    state.unitId,
                                                  ),
                                                );
                                          },
                                          child: Text(
                                            'All Questions',
                                            style: TextStyle(
                                              color: isSelected == 0
                                                  ? Colors.black
                                                  : Colors.grey.shade500,
                                              fontWeight: isSelected == 0
                                                  ? FontWeight.bold
                                                  : null,
                                            ),
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
                                                .bloc<QuestionBankBloc>()
                                                .add(
                                                  GetQuestionsByBookmark(
                                                    state.unitId,
                                                  ),
                                                );
                                          },
                                          child: Text(
                                            'Bookmarked',
                                            style: TextStyle(
                                              color: isSelected == 1
                                                  ? Colors.black
                                                  : Colors.grey.shade500,
                                              fontWeight: isSelected == 1
                                                  ? FontWeight.bold
                                                  : null,
                                            ),
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
                                                .bloc<QuestionBankBloc>()
                                                .add(
                                                  GetYourQuestions(
                                                    state.unitId,
                                                  ),
                                                );
                                          },
                                          child: Text(
                                            'Your Questions',
                                            style: TextStyle(
                                              color: isSelected == 2
                                                  ? Colors.black
                                                  : Colors.grey.shade500,
                                              fontWeight: isSelected == 2
                                                  ? FontWeight.bold
                                                  : null,
                                            ),
                                          ),
                                        ),
                                        width: 200,
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Subjective Questions',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                50,
                                      ),
                                    ),
                                    FlatButton(
                                      hoverColor:
                                          Color(0xFF1D2B64).withOpacity(.2),
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
                                  cubit: context.bloc<QuestionBankBloc>(),
                                  builder: (BuildContext context, state) {
                                    if (state is UnitQuestionsFetched) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: state.questionBankAllEntity
                                            .data.subjective_questions.length,
                                        itemBuilder:
                                            (BuildContext context, int index) =>
                                                Card(
                                          margin: EdgeInsets.all(
                                            10,
                                          ),
                                          child: ListTile(
                                            title: Row(
                                              children: [
                                                Text('Q. ${index + 1}'),
                                                Image.network(
                                                  state
                                                      .questionBankAllEntity
                                                      .data
                                                      .subjective_questions[
                                                          index]
                                                      .question_img[0],
                                                  width: 250,
                                                  height: 120,
                                                ),
                                              ],
                                            ),
                                            subtitle: Text(
                                              'Level ${state.questionBankAllEntity.data.subjective_questions[index].blooms_level}',
                                            ),
                                            trailing: IconButton(
                                              icon: Icon(Icons.bookmark),
                                              onPressed: null,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                                FlatButton(
                                  hoverColor: Color(0xFF1D2B64).withOpacity(.2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    side: BorderSide(
                                      color: Color(0xFF1D2B64),
                                    ),
                                  ),
                                  onPressed: () =>
                                      widget._tabController.index = 2,
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
                          ],
                        ),
                        Divider(
                          thickness: 3,
                          color: Colors.grey,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
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
                              cubit: context.bloc<QuestionBankBloc>(),
                              builder: (BuildContext context, state) {
                                if (state is UnitQuestionsFetched) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state.questionBankAllEntity.data
                                        .objective_questions.length,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            Card(
                                      margin: EdgeInsets.all(10),
                                      child: ListTile(
                                        title: Row(
                                          children: [
                                            Text('Q. ${index + 1}  '),
                                            Expanded(
                                                child: Text(
                                              state
                                                  .questionBankAllEntity
                                                  .data
                                                  .objective_questions[index]
                                                  .name,
                                            )),
                                          ],
                                        ),
                                        subtitle: Text(
                                          'Level ${state.questionBankAllEntity.data.objective_questions[index].blooms_level}',
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(Icons.bookmark),
                                          onPressed: null,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                            FlatButton(
                              hoverColor: Color(0xFF1D2B64).withOpacity(.2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                                side: BorderSide(
                                  color: Color(0xFF1D2B64),
                                ),
                              ),
                              onPressed: () => widget._tabController.index = 1,
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
