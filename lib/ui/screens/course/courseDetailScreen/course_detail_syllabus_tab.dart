import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/blocs/coursesBloc/courses_bloc.dart';
import '../../../../util/theme.dart';

class CourseDetailSyllabusTab extends StatelessWidget {
  final int semesterId;

  CourseDetailSyllabusTab(this.semesterId);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: context.bloc<CoursesBloc>()
        ..add(
          GetCourseSyllabus(semesterId),
        ),
      builder: (BuildContext context, state) {
        if (state is CourseSyllabusFetched) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  state.syllabusEntity.data.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Card(
                          elevation: 4.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 22.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.syllabusEntity.data[index].name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          // color: Colors.white,
                                          // decoration: ,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              50,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Objectives',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                80,
                                            color: Colors.grey.shade600),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: List.generate(
                                          state.syllabusEntity.data[index]
                                              .objectives.length,
                                          (indd) => Text(
                                            state.syllabusEntity.data[index]
                                                .objectives[indd],
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Outcome',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                80,
                                            color: Colors.grey.shade600),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: List.generate(
                                          state.syllabusEntity.data[index]
                                              .outcomes.length,
                                          (inddd) => Text(
                                            state.syllabusEntity.data[index]
                                                .outcomes[inddd],
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                ),
                                Visibility(
                                  visible: state.syllabusEntity.data[index]
                                      .topics.isNotEmpty,
                                  child: Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Topics Covered',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                50,
                                          ),
                                        ),
                                        Wrap(
                                          spacing: 5,
                                          runSpacing: 5,
                                          children: List.generate(
                                            state.syllabusEntity.data[index]
                                                .topics.length,
                                            (indddd) => Chip(
                                              backgroundColor:
                                                  EdwiselyTheme.CARD_COLOR,
                                              label: Text(
                                                state.syllabusEntity.data[index]
                                                    .topics[indddd].topic_name,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
