import 'package:edwisely/data/blocs/assessmentLandingScreen/conductdBloc/conducted_bloc.dart';
import 'package:edwisely/data/blocs/assessmentLandingScreen/coursesBloc/courses_bloc.dart';
import 'package:edwisely/ui/widgets_util/assessment_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ObjectiveTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BlocBuilder(
            cubit: context.bloc<ConductedBloc>()
              ..add(
                GetObjectiveQuestions(),
              ),
            // ignore: missing_return
            builder: (BuildContext context, state) {
              if (state is ConductedInitial) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ConductedEmpty) {
                return Center(
                  child: Text('No Assessments found'),
                );
              }
              if (state is ConductedFailed) {
                return Center(
                  child: Text('There is some server error please retry'),
                );
              }
              if (state is ConductedSuccess) {
                return ListView.builder(
                  padding: EdgeInsets.all(10),
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
                );
              }
            },
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 3,
          child: Column(
            children: [
              IconButton(
                icon: Icon(Icons.calendar_today_outlined),
                onPressed: () async => context.bloc<ConductedBloc>().add(
                      GetObjectiveQuestionsByDate(
                        await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now().subtract(
                            Duration(days: 100),
                          ),
                          lastDate: DateTime.now().add(
                            Duration(days: 100),
                          ),
                        ).then(
                          (value) => value.toString(),
                        ),
                      ),
                    ),
              ),
              Text('Filter by Date'),
              SizedBox(
                height: 20,
              ),
              BlocBuilder(
                cubit: context.bloc<CoursesBloc>(),
                builder: (BuildContext context, state) {
                  if (state is SectionsAndGetCoursesListFetched) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: DropdownButton(
                            underline: Container(),
                            hint: Text('Filter by Sections'),
                            items: [
                                  DropdownMenuItem(
                                    child: Text('All'),
                                    value: 1234567890,
                                  ),
                                ] +
                                List.generate(
                                  state.sections.data.length,
                                  (index) => DropdownMenuItem(
                                    child:
                                        Text(state.sections.data[index].name),
                                    value: state.sections.data[index].id,
                                  ),
                                ),
                            onChanged: (value) => value == 1234567890
                                ? context.bloc<ConductedBloc>().add(
                                      GetObjectiveQuestions(),
                                    )
                                : context.bloc<ConductedBloc>().add(
                                      GetObjectiveQuestionsBySection(
                                        value.toString(),
                                      ),
                                    ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: DropdownButton(
                            isDense: true,
                            underline: Container(),
                            hint: Text('Filter by Subjects'),
                            items: state.subjects,
                            onChanged: (value) => value == 1234567890
                                ? context.bloc<ConductedBloc>().add(
                                      GetObjectiveQuestions(),
                                    )
                                : context.bloc<ConductedBloc>().add(
                                      GetObjectiveQuestionsBySubject(
                                        value.toString(),
                                      ),
                                    ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Text('Fetching');
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
