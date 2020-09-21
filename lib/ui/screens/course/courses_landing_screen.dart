import 'package:dropdown_search/dropdown_search.dart';
import 'package:edwisely/data/blocs/coursesBloc/courses_bloc.dart';
import 'package:edwisely/data/model/course/coursesEntity/data.dart';
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
        flatButton: FlatButton(
          padding: EdgeInsets.all(
            10,
          ),
          hoverColor: Color(0xFF1D2B64).withOpacity(.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(
              color: Color(0xFF1D2B64),
            ),
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => BlocProvider(
                create: (BuildContext context) => CoursesBloc(),
                child: AddCourseScreen(),
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add your Courses',
                style: TextStyle(
                  color: Color(0xFF1D2B64),
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.height / 30,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                color: Color(0xFF1D2B64),
                size: MediaQuery.of(context).size.height / 25,
              )
            ],
          ),
        ),
      ).build(context),
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 5,
            color: Colors.grey,
          ),
          Expanded(
            child: Center(
              child: BlocBuilder(
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
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 17),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 5,
                              child: DropdownSearch(
                                autoFocusSearchBox: true,
                                showClearButton: true,
                                label: 'Search Courses',
                                showSearchBox: true,
                                mode: Mode.MENU,
                                items: state.coursesEntity.data,
                                onChanged: (Data data) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        BlocProvider(
                                      create: (BuildContext context) =>
                                          CoursesBloc(),
                                      child: CourseDetailScreen(
                                        data.name,
                                        data.subject_semester_id,
                                      ),
                                    ),
                                  ),
                                ),
                                showSelectedItem: false,
                                dropdownBuilder: (context, Data data,
                                        String sd) =>
                                    data != null ? Text(data.name) : Text(''),
                                filterFn: (Data data, String string) =>
                                    data.name.toLowerCase().contains(
                                          string,
                                        ),
                                popupItemBuilder: (context, Data data, bool) =>
                                    Container(
                                  padding: EdgeInsets.all(
                                    10,
                                  ),
                                  child: Text(
                                    data.name,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              height: MediaQuery.of(context).size.height / 2,
                              child: GridView(
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 35,
                                  crossAxisSpacing: 35,
                                  crossAxisCount: 3,
                                  childAspectRatio:
                                      MediaQuery.of(context).size.width /
                                          MediaQuery.of(context).size.height /
                                          2.3,
                                ),
                                children: List.generate(
                                  state.coursesEntity.data.length,
                                  (index) => GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            BlocProvider(
                                          create: (BuildContext context) =>
                                              CoursesBloc(),
                                          child: CourseDetailScreen(
                                            state
                                                .coursesEntity.data[index].name,
                                            state.coursesEntity.data[index]
                                                .subject_semester_id,
                                          ),
                                        ),
                                      ),
                                    ),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          6,
                                        ),
                                      ),
                                      elevation: 6,
                                      child: ListView(
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  5,
                                              child: state
                                                          .coursesEntity
                                                          .data[index]
                                                          .course_image ==
                                                      ''
                                                  ? Image.asset(
                                                      'placeholder_image.jpg',
                                                      fit: BoxFit.cover,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              4,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              4,
                                                    )
                                                  : Image.network(
                                                      state
                                                          .coursesEntity
                                                          .data[index]
                                                          .course_image,
                                                    ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    state.coursesEntity
                                                        .data[index].name,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 22,
                                                    ),
                                                  ),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      13,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      6,
                                                ),
                                                Text(
                                                  'Classes you teach',
                                                  style: TextStyle(
                                                    color: Color(0xFF787878),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: List.generate(
                                                    state
                                                        .coursesEntity
                                                        .data[index]
                                                        .sections
                                                        .length,
                                                    (index1) => Text(
                                                      '${state.coursesEntity.data[index].sections[index1].department_name} ${state.coursesEntity.data[index].sections[index1].department_fullname == '' ? '' : '-'} ${state.coursesEntity.data[index].sections[index1].name}',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
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
            ),
          ),
        ],
      ),
    );
  }
}
