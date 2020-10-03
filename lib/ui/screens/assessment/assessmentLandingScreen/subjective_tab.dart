import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/blocs/coursesBloc/courses_bloc.dart';
import '../../../../data/blocs/subjectiveBloc/subjective_bloc.dart';
import '../../../widgets_util/assessment_tile.dart';

class SubjectiveTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: context.bloc<SubjectiveBloc>(),
      listener: (BuildContext context, state) {
        if (state is SubjectiveEmpty) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('There were no assessments related to that subject'),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder(
              cubit: context.bloc<CoursesBloc>(),
              builder: (BuildContext context, state) {
                if (state is CoursesListFetched) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: DropdownButton(
                      underline: Container(),
                      hint: Text('Filter by Subjects'),
                      items: state.subjects,
                      onChanged: (value) => value == 1234567890
                          ? context.bloc<SubjectiveBloc>().add(
                                GetSubjectiveTests(),
                              )
                          : context.bloc<SubjectiveBloc>().add(
                                GetSubjectiveTestsBYSubjectId(
                                  value,
                                ),
                              ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
            Expanded(
              child: BlocBuilder(
                cubit: context.bloc<SubjectiveBloc>(),
                // ignore: missing_return
                builder: (BuildContext context, state) {
                  if (state is SubjectiveInitial) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is SubjectiveEmpty) {
                    return Center(
                      child: Text('No Assessments found'),
                    );
                  }
                  if (state is SubjectiveFailed) {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('There is some server error please retry'),
                        RaisedButton(
                          color: Color(0xFF1D2B64).withOpacity(.3),
                          onPressed: () => context.bloc<SubjectiveBloc>().add(
                                GetSubjectiveTests(),
                              ),
                          child: Text('Return Home'),
                        )
                      ],
                    );
                  }
                  if (state is SubjectiveSuccess) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 32.0,
                        mainAxisSpacing: 32.0,
                        childAspectRatio: 3 / 1,
                      ),
                      itemCount: state.questionsEntity.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AssessmentTile(
                          state.questionsEntity.data[index].id,
                          state.questionsEntity.data[index].name,
                          state.questionsEntity.data[index].description,
                          state.questionsEntity.data[index].questions_count.toString(),
                          state.questionsEntity.data[index].doe,
                          state.questionsEntity.data[index].start_time,
                          //todo add subject name thru api
                          '',
                          state.questionsEntity.data[index].subject_id,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
