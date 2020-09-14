import 'package:dio/dio.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/blocs/questionBank/question_bank_bloc.dart';
import 'package:edwisely/data/cubits/unit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseDetailQuestionBankTab extends StatelessWidget {
  final subjectId;

  CourseDetailQuestionBankTab(this.subjectId);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 6,
          child: BlocBuilder(
            cubit: context.bloc<UnitCubit>(),
            builder: (BuildContext context, state) {
              if (state is CourseUnitFetched) {
                context.bloc<QuestionBankBloc>().add(
                      GetUnitQuestions(
                        subjectId,
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
                              subjectId,
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
        Expanded(
          child: BlocBuilder(
            cubit: context.bloc<QuestionBankBloc>(),
            builder: (BuildContext context, state) {
              if (state is UnitQuestionsFetched) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: ListView(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width:
                                MediaQuery.of(context).size.width * (3.5 / 5),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Subjective Questions',
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
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.questionBankAllEntity.data
                                .subjective_questions.length,
                            itemBuilder: (BuildContext context, int index) =>
                                ListTile(
                              title: Text(
                                state.questionBankAllEntity.data
                                    .subjective_questions[index].type_name,
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(
                        thickness: 3,
                        color: Colors.grey,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width:
                                MediaQuery.of(context).size.width * (3.5 / 5),
                            child: Row(
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
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.questionBankAllEntity.data
                                .objective_questions.length,
                            itemBuilder: (BuildContext context, int index) =>
                                ListTile(
                              title: Row(
                                children: [
                                  Text('Q ${index + 1} : '),
                                  Expanded(
                                    child: Text(
                                      state.questionBankAllEntity.data
                                          .objective_questions[index].name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                  icon: Icon(
                                    state
                                                .questionBankAllEntity
                                                .data
                                                .objective_questions[index]
                                                .bookmarked ==
                                            1
                                        ? Icons.bookmark
                                        : Icons.bookmark_border_outlined,
                                  ),
                                  onPressed: () async {
                                    // im tired and going the easy way
                                    final response = await EdwiselyApi.dio.post(
                                      'addBookmark',
                                      data: FormData.fromMap(
                                        {
                                          'type': 'objective_questions',
                                          'id': state.questionBankAllEntity.data
                                              .objective_questions[index].id
                                        },
                                      ),
                                    );
                                    print(response.data);
                                    if (response.statusCode == 200) {
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(response.data['message']),
                                        ),
                                      );
                                    } else {
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Adding to Bookmarks Failed'),
                                        ),
                                      );
                                    }
                                  }),
                              subtitle: Row(
                                children: [
                                  Row(
                                    children: [
                                      Text('Correct Answer : '),
                                      Text(
                                        state
                                            .questionBankAllEntity
                                            .data
                                            .objective_questions[index]
                                            .solution,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Level : '),
                                      Text(
                                        state
                                            .questionBankAllEntity
                                            .data
                                            .objective_questions[index]
                                            .blooms_level
                                            .toString(),
                                      ),
                                    ],
                                  )
                                ],
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        )
      ],
    );
  }
}
