import 'package:edwisely/data/blocs/questionBank/question_bank_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseDetailsSubjectivePart extends StatefulWidget {
  @override
  _CourseDetailsSubjectivePartState createState() =>
      _CourseDetailsSubjectivePartState();
}

class _CourseDetailsSubjectivePartState
    extends State<CourseDetailsSubjectivePart> {
  // String dropDownValue = 'All';
  // String radioValue = 'All';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: context.bloc<QuestionBankBloc>(),
      builder: (BuildContext context, state) {
        if (state is UnitQuestionsFetched) {
          return ListView.separated(
            shrinkWrap: true,
            itemCount:
                state.questionBankAllEntity.data.subjective_questions.length,
            itemBuilder: (BuildContext context, int index) => ListTile(
              title: Row(
                children: [
                  Text('Q. ${index + 1}'),
                  Image.network(
                    state.questionBankAllEntity.data.subjective_questions[index]
                        .question_img[0],
                    width: 250,
                    height: 250,
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
