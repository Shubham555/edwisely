import 'package:dio/dio.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/util/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../../data/blocs/coursesBloc/courses_bloc.dart';
import '../../../data/model/course/coursesEntity/data.dart';
import '../../../data/provider/selected_page.dart';
import '../../widgets_util/big_app_bar.dart';
import '../../widgets_util/navigation_drawer.dart';
import '../authorization/edwisely_landing_screen.dart';
import 'courseDetailScreen/course_detail_screen.dart';

class CoursesLandingScreen extends StatefulWidget {
  @override
  _CoursesLandingScreenState createState() => _CoursesLandingScreenState();
}

class _CoursesLandingScreenState extends State<CoursesLandingScreen> {
  final ScrollController _scrollController = ScrollController();

  final _courseBloc = CoursesBloc();
  var pageProvider;
  bool _isCollapsed = false;

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pageProvider = Provider.of<SelectedPageProvider>(context, listen: false);

    return WillPopScope(
      onWillPop: () async{
        Provider.of<SelectedPageProvider>(context, listen: false).setPreviousIndex();
        return true;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Row(
            children: [
              NavigationDrawer(
                isCollapsed: _isCollapsed,
                key: context.watch<SelectedPageProvider>().navigatorKey,
              ),
              BlocListener(
                cubit: _courseBloc,
                listener: (BuildContext context, state) {
                  if (state is LoginFailed) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => EdwiselyLandingScreen(),
                      ),
                    );
                  }
                },
                child: Expanded(
                  child: Column(
                    children: [
                      BigAppBar(
                        actions: null,
                        titleText: 'Your Courses',
                        bottomTab: null,
                        appBarSize: MediaQuery.of(context).size.height / 3.5,
                        appBarTitle: Text(
                          'Edwisely',
                          style: TextStyle(color: Colors.black),
                        ),
                        flatButton: null,
                        route: 'Home > All Courses',
                      ).build(context),
                      Center(
                        child: BlocBuilder(
                          cubit: _courseBloc
                            ..add(
                              GetCoursesByFaculty(),
                            ),
                          builder: (BuildContext context, state) {
                            if (state is CoursesFetched) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal: MediaQuery.of(context).size.width * 0.17,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    _buildSearchCourseField(context, state),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    _buildCoursesGrid(context, state),
                                  ],
                                ),
                              );
                            } else {
                              return Expanded(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCoursesGrid(BuildContext context, CoursesFetched state) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height / 1.56,
        child: Scrollbar(
          isAlwaysShown: true,
          controller: _scrollController,
          child: GridView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 35,
              crossAxisSpacing: 35,
              crossAxisCount: 3,
              childAspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.height / 1.9,
            ),
            itemCount: state.coursesEntity.data.length,
            itemBuilder: (context, index) => _courseCard(context, index, state),
          ),
        ),
      ),
    );
  }

  Widget _courseCard(BuildContext context, int index, CoursesFetched state) {
    return GestureDetector(
      // onTap: () => Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => CourseDetailScreen(
      //       state.coursesEntity.data[index].name,
      //       state.coursesEntity.data[index].subject_semester_id,
      //       state.coursesEntity.data[index].id,dfdf
      //     ),
      //   ),
      // ),
      onTap: () => MyRouter().navigateTo(pageProvider.navigatorKey, '/course-details-screen', {
        'name': state.coursesEntity.data[index].name,
        'subject_semester_id': state.coursesEntity.data[index].subject_semester_id,
        'id': state.coursesEntity.data[index].id,
      }),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            6,
          ),
        ),
        elevation: 2.0,
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: MediaQuery.of(context).size.height / 5,
                child: state.coursesEntity.data[index].course_image == ''
                    ? Image.asset(
                        'placeholder_image.jpg',
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 4,
                      )
                    : Image.network(
                        state.coursesEntity.data[index].course_image,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 6,
                    child: Text(
                      state.coursesEntity.data[index].name,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  // Wrap(
                  //   runSpacing: 4.0,
                  //   spacing: 8.0,
                  //   children: List.generate(
                  //     state.coursesEntity.data[index].sections.length > 4
                  //         ? 4
                  //         : state.coursesEntity.data[index].sections.length,
                  //     (index1) => Container(
                  //       padding: const EdgeInsets.symmetric(
                  //         vertical: 1,
                  //         horizontal: 1,
                  //       ),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(12.0),
                  //         color: EdwiselyTheme.CARD_COLOR,
                  //       ),
                  //       child: Row(
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: [
                  //           Text(
                  //             '${state.coursesEntity.data[index].sections[index1].department_name} ${state.coursesEntity.data[index].sections[index1].department_fullname == '' ? '' : '-'} ${state.coursesEntity.data[index].sections[index1].name}',
                  //             style: TextStyle(
                  //               fontSize: 16,
                  //             ),
                  //           ),
                  //           IconButton(
                  //               padding: EdgeInsets.zero,
                  //               icon: Icon(
                  //                 Icons.delete,
                  //                 size: 10,
                  //               ),
                  //               onPressed: () => _deleteSectionFromAFaculty(
                  //                   state.coursesEntity.data[index]
                  //                       .sections[index1].faculty_section_id,
                  //                   context))
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchCourseField(BuildContext context, state) {
    return Container(
      width: MediaQuery.of(context).size.width / 5,
      child: TypeAheadField(
        suggestionsCallback: (pttrn) async {
          List<Data> courses = List();
          courses.addAll(state.coursesEntity.data);
          courses.retainWhere(
            (element) => element.name.toLowerCase().contains(
                  pttrn.toLowerCase(),
                ),
          );
          return courses;
        },
        textFieldConfiguration: TextFieldConfiguration(
          style: DefaultTextStyle.of(context).style.copyWith(
                fontStyle: FontStyle.normal,
              ),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Search Courses',
            suffixIcon: Icon(Icons.search),
          ),
        ),
        itemBuilder: (context, Data data) {
          return ListTile(
            title: Text(data.name),
          );
        },
        onSuggestionSelected: (data) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => CourseDetailScreen(data.name, data.subject_semester_id, data.id),
          ),
        ),
        // onSuggestionSelected: (data) => MyRouter().navigateTo(pageProvider.navigatorKey, '/course-details-screen', {
        //   'name': data.name,
        //   'subject_semester_id': data.subject_semster_id,
        //   'id': data.id,
        // }),
        //  Navigator.pushNamed(
        //   context,
        //   '/course-details-screen',
        //   arguments: {
        //     'name': data.name,
        //     'subject_semester_id': data.subject_semster_id,
        //     'id': data.id,
        //   },
      ),
    );
  }

  _deleteSectionFromAFaculty(int facultySectionId, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Delete Section ?'),
        actions: [
          FlatButton(
            onPressed: () => _deleteSectionFromAFacultyBackend(facultySectionId),
            child: Text('Yes'),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No'),
          ),
        ],
      ),
    );
  }

  _deleteSectionFromAFacultyBackend(int facultySectionId) async {
    final response = await EdwiselyApi.dio.post(
      'common/facultyUnassingSubjectSection',
      data: FormData.fromMap(
        {
          'data': facultySectionId,
        },
      ),
    );

    if (response.data['message'] == 'Successfully deleted the data') {

      _courseBloc.add(
        GetCoursesByFaculty(),
      );
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      Toast.show('There was some error', context);
    }
  }
}
