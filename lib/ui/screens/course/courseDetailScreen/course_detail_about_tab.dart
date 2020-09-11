import 'package:edwisely/data/blocs/assessmentLandingScreen/coursesBloc/courses_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseDetailAboutTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: context.bloc<CoursesBloc>(),
      builder: (BuildContext context, state) {
        if (state is CourseAboutDetailsFetched) {
          return SingleChildScrollView(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
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
                        Text(state.courseEntity.data.description),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Learning Objectives',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              state.courseEntity.data.objectives.length,
                              (index) => Text(
                                '● ${state.courseEntity.data.objectives[index]}',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              state.courseEntity.data.outcomes.length,
                              (index) => Text(
                                '● ${state.courseEntity.data.outcomes[index]}',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Pre-requisite Knowledge Required',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        //todo not provided in api
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width / 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mode of Instruction',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          //todo not given ion api
                          Text(
                            'Your Classes',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                state.courseEntity.data.sections.length,
                                (index) => Text(
                                  '● ${state.courseEntity.data.sections[index].name}',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
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
