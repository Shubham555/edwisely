import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/blocs/coursesBloc/courses_bloc.dart';

class CourseDetailAboutTab extends StatelessWidget {
  final int semesterId;

  CourseDetailAboutTab(this.semesterId);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: context.bloc<CoursesBloc>()
        ..add(
          GetCourse(semesterId),
        ),
      builder: (BuildContext context, state) {
        if (state is CourseAboutDetailsFetched) {
          return SingleChildScrollView(
            child: Card(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: state.courseEntity.data.description != '',
                            child: Text(
                              'Course Description',
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.height / 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            state.courseEntity.data.description,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            visible:
                                state.courseEntity.data.objectives.isNotEmpty,
                            child: Text(
                              'Learning Objectives',
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.height / 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                state.courseEntity.data.objectives.length,
                                (index) => Row(
                                  children: [
                                    Container(
                                      width: 7,
                                      height: 7,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(
                                          60,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      state.courseEntity.data.objectives[index],
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            visible: state.courseEntity.data.outcomes.isNotEmpty,
                            child: Text(
                              'Learning Outcomes',
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.height / 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                state.courseEntity.data.outcomes.length,
                                (index) => Row(
                                  children: [
                                    Container(
                                      width: 7,
                                      height: 7,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(
                                          60,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      state.courseEntity.data.outcomes[index],
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width / 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          child: Card(
                            child: state.courseEntity.data.image == ''
                                ? Icon(
                                    Icons.book,
                                    size: 50,
                                  )
                                : Image.network(
                                    state.courseEntity.data.image,
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your Classes',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height / 80,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade600),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                    state.courseEntity.data.sections.length,
                                    (index) => Text(
                                      state
                                          .courseEntity.data.sections[index].name,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
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
