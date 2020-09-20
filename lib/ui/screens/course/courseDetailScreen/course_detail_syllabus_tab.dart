import 'package:edwisely/data/blocs/coursesBloc/courses_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseDetailSyllabusTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: context.bloc<CoursesBloc>(),
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
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.syllabusEntity.data[index].name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.height /
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
                                width: MediaQuery.of(context).size.width / 1.5,
                              ),
                              Visibility(
                                visible: state.syllabusEntity.data[index].topics
                                    .isNotEmpty,
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
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: List.generate(
                                          state.syllabusEntity.data[index]
                                              .topics.length,
                                          (indddd) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Chip(
                                              backgroundColor: Color(
                                                0xFF1F2C65,
                                              ),
                                              label: Text(
                                                state.syllabusEntity.data[index]
                                                    .topics[indddd].topic_name,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
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
                        SizedBox(
                          height: 40,
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
