import 'package:edwisely/data/blocs/coursesBloc/courses_bloc.dart';
import 'package:edwisely/ui/screens/course/add_course_screen.dart';
import 'package:edwisely/ui/screens/course/courseDetailScreen/course_detail_screen.dart';
import 'package:edwisely/ui/widgets_util/big_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursesLandingScreen extends StatelessWidget {
  final _courseBloc = CoursesBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BigAppBar(
              actions: null,
              titleText: 'Your Courses',
              bottomTab: null,
              appBarSize: MediaQuery.of(context).size.height / 3.5,
              appBarTitle: Text(
                'Edwisely',
                style: TextStyle(color: Colors.black),
              ),
              flatButton: null)
          .build(context),
      body: BlocBuilder(
        cubit: _courseBloc
          ..add(
            GetCoursesByFaculty(),
          ),
        builder: (BuildContext context, state) {
          if (state is CoursesFetched) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Here are the courses that you teach',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height / 40,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        runSpacing: 30,
                        spacing: 30,
                        children: List.generate(
                          state.coursesEntity.data.length,
                          (index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        BlocProvider(
                                      create: (BuildContext context) =>
                                          CoursesBloc(),
                                      child: CourseDetailScreen(
                                        state.coursesEntity.data[index].name,
                                        state.coursesEntity.data[index]
                                            .subject_semester_id,
                                      ),
                                    ),
                                  ),
                                ),
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  child: Card(
                                    child: state.coursesEntity.data[index]
                                                .course_image ==
                                            ''
                                        ? Icon(
                                            Icons.book,
                                            size: 50,
                                          )
                                        : Image.network(state.coursesEntity
                                            .data[index].course_image),
                                  ),
                                ),
                              ),
                              Container(
                                width: 150,
                                child: Text(
                                  state.coursesEntity.data[index].name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              Text(
                                'Classes you teach',
                                style: TextStyle(
                                  color: Color(0xFF787878),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  state.coursesEntity.data[index].sections
                                      .length,
                                  (index1) => Text(
                                    state.coursesEntity.data[index]
                                        .sections[index1].name,
                                    style: TextStyle(),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => BlocProvider(
              create: (BuildContext context) => CoursesBloc(),
              child: AddCourseScreen(),
            ),
          ),
        ),
        label: Text('Add Your Courses'),
      ),
    );
  }
}
