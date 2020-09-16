import 'package:edwisely/data/blocs/questionBank/question_bank_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseDetailsObjectivePart extends StatefulWidget {
  @override
  _CourseDetailsObjectivePartState createState() =>
      _CourseDetailsObjectivePartState();
}

class _CourseDetailsObjectivePartState
    extends State<CourseDetailsObjectivePart> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: context.bloc<QuestionBankBloc>(),
      builder: (BuildContext context, state) {
        if (state is UnitQuestionsFetched) {
          return Column(
            children: [
              // Card(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       DropdownButton(
              //         items: [
              //               DropdownMenuItem(
              //                 child: Text('All'),
              //                 value: 'All',
              //               ),
              //             ] +
              //             state.questionBankAllEntity.data.subjective_questions
              //                 .map(
              //                   (e) => DropdownMenuItem(
              //                     child: Text(e.type),
              //                     value: e.type.toString(),
              //                   ),
              //                 )
              //                 .toList(),
              //         value: dropDownValue,
              //         onChanged: (value) => null,
              //       ),
              //       Row(
              //         children: [
              //           Radio(
              //             value: 'Bookmarks',
              //             groupValue: radioValue,
              //             onChanged: null,
              //           ),
              //           Text(
              //             'Bookmarks',
              //           )
              //         ],
              //       ),
              //       Row(
              //         children: [
              //           Radio(
              //             value: 'Your Questions',
              //             groupValue: radioValue,
              //             onChanged: null,
              //           ),
              //           Text(
              //             'Your Questions',
              //           )
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              ListView.separated(
                shrinkWrap: true,
                itemCount:
                    state.questionBankAllEntity.data.objective_questions.length,
                itemBuilder: (BuildContext context, int index) => ListTile(
                  title: Row(
                    children: [
                      Text('Q. ${index + 1}  '),
                      Expanded(
                        child: Text(
                          state.questionBankAllEntity.data
                              .objective_questions[index].name,
                        ),
                      ),
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
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    thickness: 2,
                    color: Colors.grey,
                  );
                },
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
