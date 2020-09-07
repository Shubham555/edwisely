import 'package:edwisely/data/blocs/assessmentLandingScreen/subjectiveBloc/subjective_bloc.dart';
import 'package:edwisely/ui/widgets_util/assessment_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubjectiveTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: context.bloc<SubjectiveBloc>(),
      listener: (BuildContext context, state) {
        if (state is SubjectiveEmpty) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('There were no assessments related to that subject'),
            ),
          );
        }
      },
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
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('There were no assessments related to that subject'),
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
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.questionsEntity.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AssessmentTile(
                            state.questionsEntity.data[index].name,
                            state.questionsEntity.data[index].description,
                            state.questionsEntity.data[index].questions_count
                                .toString(),
                            state.questionsEntity.data[index].doe,
                            state.questionsEntity.data[index].start_time);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: DropdownButton(
                        hint: Text('Filter by Subjects'),
                        items: state.subjects,
                        onChanged: (value) => value == 1234567890
                            ? context.bloc<SubjectiveBloc>().add(
                                  GetSubjectiveTests(),
                                )
                            : context.bloc<SubjectiveBloc>().add(
                                  GetSubjectiveTestsBYSubjectId(value),
                                ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
