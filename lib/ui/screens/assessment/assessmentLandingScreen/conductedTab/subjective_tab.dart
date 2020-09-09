import 'package:edwisely/data/blocs/assessmentLandingScreen/conductdBloc/conducted_bloc.dart';
import 'package:edwisely/data/blocs/assessmentLandingScreen/coursesBloc/courses_bloc.dart';
import 'package:edwisely/ui/widgets_util/assessment_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ConductedTabSubjectiveTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: BlocBuilder(
            cubit: context.bloc<ConductedBloc>()
              ..add(
                GetSubjectiveQuestions(),
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
                      state.questionsEntity.data[index].start_time,
                    );
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
                      GetSubjectiveQuestionsByDate(
                        await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          //todo change for production date
                          firstDate: DateTime.now().subtract(
                            Duration(days: 100),
                          ),
                          lastDate: DateTime.now().add(
                            Duration(days: 100),
                          ),
                        ).then(
                          (value) {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Fetching Assessments after ${value == null ? 'Yesterday' : DateFormat('EEE d MMM yyyy').format(value)}'),
                              ),
                            );
                            return value == null
                                ? DateTime.now()
                                    .subtract(
                                      Duration(days: 1),
                                    )
                                    .toString()
                                : value.toString();
                          },
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
                            hint: Text('Filter Assessments by Sections'),
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
                                      GetSubjectiveQuestions(),
                                    )
                                : context.bloc<ConductedBloc>().add(
                                      GetSubjectiveQuestionsBySection(
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
                            hint: Text('Filter Assessments by Subjects'),
                            items: state.subjects,
                            onChanged: (value) => value == 1234567890
                                ? context.bloc<ConductedBloc>().add(
                                      GetSubjectiveQuestions(),
                                    )
                                : context.bloc<ConductedBloc>().add(
                                      GetSubjectiveQuestionsBySubject(
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
