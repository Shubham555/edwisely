import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../data/blocs/conductdBloc/conducted_bloc.dart';
import '../../../../../data/blocs/coursesBloc/courses_bloc.dart';
import '../../../../widgets_util/assessment_tile.dart';

class ConductedTabObjectiveTab extends StatelessWidget {
  int subhjectId;
  @override
  Widget build(BuildContext context) {
    DateTime initialDate;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              margin:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.calendar_today_outlined),
                    onPressed: () async => context.bloc<ConductedBloc>().add(
                          GetObjectiveQuestionsByDate(
                            await showDatePicker(
                              context: context,
                              initialDate: initialDate ?? DateTime.now(),
                              firstDate: DateTime.now().subtract(
                                Duration(days: 100),
                              ),
                              lastDate: DateTime.now().add(
                                Duration(days: 100),
                              ),
                            ).then(
                              (value) {
                                initialDate = value;
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
                ],
              ),
            ),
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
                      Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        margin: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        child: DropdownButton(
                          underline: SizedBox.shrink(),
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
                                  child: Text(state.sections.data[index].name),
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
                      Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        margin: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        child: DropdownButton(
                          underline: SizedBox.shrink(),
                          hint: Text('Filter Assessments by Subjects'),
                          value: subhjectId,
                          items: state.subjects,
                          onChanged: (value) {
                            print(value);
                            value == 1234567890
                                ? context.bloc<ConductedBloc>().add(
                                      GetObjectiveQuestions(),
                                    )
                                : context.bloc<ConductedBloc>().add(
                                      GetObjectiveQuestionsBySubject(
                                        value.toString(),
                                      ),
                                    );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return Text('');
                }
              },
            ),
          ],
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
                    childAspectRatio: 3 / 1.2, // TODO: Check data formatting
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
                      state.questionsEntity.data[index].start_time == ""
                          ? state.questionsEntity.data[index].created_at
                          : state.questionsEntity.data[index].start_time,
                      '',
                      //for subject name
                      1,
                      true,
                      state.questionsEntity.data[index].test_completed,
                      //check these two variables what is coming
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
