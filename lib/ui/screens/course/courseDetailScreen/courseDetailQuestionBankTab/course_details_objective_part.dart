import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart';

import '../../../../../data/blocs/questionBank/question_bank_bloc.dart';

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
          return ListView.separated(
            shrinkWrap: true,
            itemCount:
                state.questionBankAllEntity.data.objective_questions.length,
            itemBuilder: (BuildContext context, int index) => ListTile(
              title: Row(
                children: [
                  Text('Q. ${index + 1}  '),
                  Expanded(
                    child: Text(
                      parse(state.questionBankAllEntity.data
                              .objective_questions[index].name)
                          .body
                          .text,
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
