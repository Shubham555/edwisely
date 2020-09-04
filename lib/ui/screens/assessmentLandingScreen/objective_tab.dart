import 'dart:developer';

import 'package:edwisely/data/blocs/assessmentLandingScreen/objectiveBloc/objective_bloc.dart';
import 'package:edwisely/ui/widgets_util/assessment_tile.dart';
import 'package:flutter/material.dart';
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
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('There were no assessments related to that subject'),
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
                        onChanged: (value) => context.bloc<ObjectiveBloc>().add(
                              GetObjectiveTestsBYSubjectId(value),
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
