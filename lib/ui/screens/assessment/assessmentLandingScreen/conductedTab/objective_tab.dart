import 'package:edwisely/data/blocs/conductdBloc/conducted_bloc.dart';
import 'package:edwisely/data/blocs/coursesBloc/courses_bloc.dart';
import 'package:edwisely/ui/widgets_util/assessment_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ConductedTabObjectiveTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // width: MediaQuery.of(context).size.width / 3,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.calendar_today_outlined),
                onPressed: () async => context.bloc<ConductedBloc>().add(
                      GetObjectiveQuestionsByDate(
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
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
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
                            hint: Text('Filter Assessments by Subjects'),
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
        ),
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
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 32.0,
                    mainAxisSpacing: 32.0,
                    childAspectRatio: 3 / 1,
                  ),
                  padding: EdgeInsets.all(10),
                  shrinkWrap: true,
                  itemCount: state.questionsEntity.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AssessmentTile(
                      state.questionsEntity.data[index].id,
                      state.questionsEntity.data[index].name,
                      state.questionsEntity.data[index].description,
                      state.questionsEntity.data[index].questions_count
                          .toString(),
                      state.questionsEntity.data[index].doe,
                      state.questionsEntity.data[index].start_time,
                      //todo add subject name thru api
                      '',
                      state.questionsEntity.data[index].sent,//check these two variables what is coming
                      state.questionsEntity.data[index].students_count,
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
