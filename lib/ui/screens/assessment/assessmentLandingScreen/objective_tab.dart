import 'package:edwisely/data/blocs/assessmentLandingScreen/coursesBloc/courses_bloc.dart';
import 'package:edwisely/data/blocs/assessmentLandingScreen/objectiveBloc/objective_bloc.dart';
import 'package:edwisely/ui/widgets_util/assessment_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ObjectiveTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: context.bloc<ObjectiveBloc>(),
      listener: (BuildContext context, state) {
        if (state is ObjectiveEmpty) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('There were no assessments related to that subject'),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BlocBuilder(
                cubit: context.bloc<ObjectiveBloc>(),
                // ignore: missing_return
                builder: (BuildContext context, state) {
                  if (state is ObjectiveInitial) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ObjectiveEmpty) {
                    return Center(
                      child: Text('No Assessments found'),
                    );
                  }
                  if (state is ObjectiveFailed) {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('There is some server error please retry'),
                        RaisedButton(
                          color: Color(0xFF1D2B64).withOpacity(.3),
                          onPressed: () => context.bloc<ObjectiveBloc>().add(
                                GetObjectiveTests(),
                              ),
                          child: Text('Return Home'),
                        )
                      ],
                    );
                  }
                  if (state is ObjectiveSuccess) {
                    return ListView.builder(
                      padding: EdgeInsets.all(10),
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
                    );
                  }
                },
              ),
            ),
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
                          ? context.bloc<ObjectiveBloc>().add(
                                GetObjectiveTests(),
                              )
                          : context.bloc<ObjectiveBloc>().add(
                                GetObjectiveTestsBYSubjectId(
                                  value,
                                ),
                              ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
