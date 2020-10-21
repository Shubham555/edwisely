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
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                  )),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Course Description',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40,
                              fontWeight: FontWeight.bold,
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
                          Text(
                            'Learning Objectives',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      width: 10,
                                      height: 10,
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
                                      state.courseEntity.data.objectives[index]
                                          .trim(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 16.0,
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
                          Text(
                            'Learning Outcomes',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 4.0),
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
                                      state.courseEntity.data.outcomes[index]
                                          .trim(),
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 16.0,
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
                    width: MediaQuery.of(context).size.width / 4.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Container(
                        //   width: 150,
                        //   height: 150,
                        //   child: Card(
                        //     child: state.courseEntity.data.image == ''
                        //         ? Icon(
                        //             Icons.book,
                        //             size: 50,
                        //           )
                        //         : Image.network(
                        //             state.courseEntity.data.image,
                        //           ),
                        //   ),
                        // ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: state.courseEntity.data.image == ''
                              ? Image.asset('assets/placeholder_image.jpg')
                              : Image.network(
                                  state.courseEntity.data.image,
                                ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 4.5,
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black,
                                )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your Classes',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                    state.courseEntity.data.sections.length,
                                    (index) => Text(
                                      state.courseEntity.data.sections[index]
                                          .name,
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
