import 'package:auto_size_text/auto_size_text.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:edwisely/data/blocs/coursesBloc/courses_bloc.dart';
import 'package:edwisely/data/cubits/add_course_cubit.dart';
import 'package:edwisely/data/model/course/getAllCourses/data.dart';
import 'package:edwisely/data/model/course/getAllCourses/departments.dart';
import 'package:edwisely/data/model/course/sectionEntity/SectionEntity.dart';
import 'package:edwisely/data/model/course/sectionEntity/data.dart'
    as sectionDta;
import 'package:edwisely/ui/widgets_util/big_app_bar.dart';
import 'package:edwisely/ui/widgets_util/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../../data/provider/selected_page.dart';

class AddCourseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: BlocListener(
            cubit: context.bloc<AddCourseCubit>(),
            listener: (BuildContext context, state) {
              if (state is CourseAdded) {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('Course Added Successfully')));
                Future.delayed(
                  Duration(seconds: 2),
                  () {
                    // Navigator.pop(context);
                    // Navigator.pop(context);
                    // Provider.of<SelectedPageProvider>(context, listen: false).setPreviousIndex ();
                  },
                );
              }
              if (state is CoursesError) {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
                Future.delayed(Duration(seconds: 2), () {
                  // Navigator.pop(context);
                  // Navigator.pop(context);
                  // Provider.of<SelectedPageProvider>(context, listen: false).setPreviousIndex ();
                });
              }
            },
            child: BlocBuilder(
              cubit: context.bloc<CoursesBloc>()..add(GetAllCourses()),
              builder: (BuildContext context, state) {
                if (state is AllCoursesFetched) {
                  return Row(
                    children: [
                      NavigationDrawer(
                        isCollapsed: false,
                        key: context.watch<SelectedPageProvider>().navigatorKey,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigAppBar(
                                    actions: null,
                                    titleText: 'Add Courses',
                                    //5 minute dedo a raha hioon Ha sarkar
                                    bottomTab: null,
                                    appBarSize:
                                        MediaQuery.of(context).size.height /
                                            3.5,
                                    appBarTitle: Text('Edwisely'),
                                    flatButton: null)
                                .build(context),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.17,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width /
                                          100,
                                    ),
                                    child: TypeAheadField(
                                      textFieldConfiguration:
                                          TextFieldConfiguration(
                                        style: DefaultTextStyle.of(context)
                                            .style
                                            .copyWith(
                                              fontStyle: FontStyle.normal,
                                            ),
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Search Courses'),
                                      ),
                                      suggestionsCallback: (pttrn) async {
                                        List<Data> courses = List();
                                        courses.addAll(
                                            state.getAllCoursesEntity.data);
                                        courses.retainWhere(
                                          (element) => element.name
                                              .toLowerCase()
                                              .contains(
                                                pttrn.toLowerCase(),
                                              ),
                                        );
                                        return courses;
                                      },
                                      itemBuilder: (context, Data data) {
                                        return ListTile(
                                          title: Text(data.name),
                                        );
                                      },
                                      onSuggestionSelected: (data) =>
                                          Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              _showDialog(
                                            context,
                                            data,
                                            data.departments,
                                            state.sectionEntity,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 32.0),
                                  DropdownButton(items: null, onChanged: null)
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: GridView(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 35,
                                    crossAxisSpacing: 35,
                                    crossAxisCount: 3,
                                    childAspectRatio:
                                        MediaQuery.of(context).size.width /
                                            MediaQuery.of(context).size.height /
                                            1.9,
                                  ),
                                  children: List.generate(
                                    state.getAllCoursesEntity.data.length,
                                    (upperIndex) => Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          6,
                                        ),
                                      ),
                                      elevation: 6,
                                      child: _buildCourseTile(
                                          upperIndex, context, state),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                if (state is CourseAdded) {
                  return Column(
                    children: [
                      CircularProgressIndicator(),
                      Text('Course Added '),
                    ],
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
      ),
    );
  }

  Widget _buildCourseTile(int upperIndex, BuildContext context, state) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: MediaQuery.of(context).size.height / 5,
              child: state.getAllCoursesEntity.data[upperIndex].course_image ==
                      ''
                  ? Image.asset(
                      'placeholder_image.jpg',
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width / 4,
                    )
                  : Image.network(
                      state.getAllCoursesEntity.data[upperIndex].course_image,
                    ),
            ),
          ),
          SizedBox(height: 12.0),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: MediaQuery.of(context).size.height * 0.0001),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
              width: double.infinity,
              child: AutoSizeText(
                state.getAllCoursesEntity.data[upperIndex].name,
                maxLines: 3,
                maxFontSize: 32.0,
                minFontSize: 18.0,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 18.0,
            ),
            child: Text(
              'Departments',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height / 70,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 18.0,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  state.getAllCoursesEntity.data[upperIndex].departments.length,
                  (index) => Container(
                    height: MediaQuery.of(context).size.height * 0.03,
                    margin: const EdgeInsets.symmetric(horizontal: 6.0),
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 12.0,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xfff7f1e3),
                    ),
                    child: Text(
                      state.getAllCoursesEntity.data[upperIndex]
                          .departments[index].name,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SizedBox(
                width: 48.0,
                child: RaisedButton(
                  onPressed: () => _showDialog(
                    context,
                    state.getAllCoursesEntity.data[upperIndex],
                    state.getAllCoursesEntity.data[upperIndex].departments,
                    state.sectionEntity,
                  ),
                  padding: const EdgeInsets.all(0),
                  color: Color(0xFF1D2B64),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showDialog(
    BuildContext outerContext,
    Data data,
    List<Departments> departments,
    SectionEntity sectionEntity,
  ) {
    int branch;
    List<int> sections = [];
    showDialog(
      context: outerContext,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return AlertDialog(
              title: Text(
                'Finalize Adding ${data.name} to Your Courses',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.height / 50,
                ),
              ),
              content: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Which Department Do You Teach ? ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height / 50,
                      ),
                    ),
                    ChipsChoice.single(
                      value: branch,
                      options: ChipsChoiceOption.listFrom(
                        source: departments,
                        value: (i, Departments dep) => dep.subject_semester_id,
                        label: (i, Departments dep) => dep.name,
                      ),
                      onChanged: (val) => setState(() {
                        branch = val;
                      }),
                    ),
                    Text(
                      'Pick Your Class',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height / 50,
                      ),
                    ),
                    ChipsChoice<int>.multiple(
                      value: sections,
                      isWrapped: true,
                      options: ChipsChoiceOption.listFrom(
                        source: sectionEntity.data,
                        value: (i, sectionDta.Data v) => v.id,
                        label: (i, sectionDta.Data v) => v.name,
                      ),
                      onChanged: (val) => setState(
                        () => sections = val,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton.icon(
                          onPressed: () {
                            print('department : $branch');
                            print('sections : $sections');
                            print('subject : ${data.id}');
                            if (branch == null || sections.isEmpty) {
                              Toast.show(
                                  'Please select at least one section and one department',
                                  context,
                                  duration: 4);
                            }
                            outerContext
                                .bloc<AddCourseCubit>()
                                .addCourseToFaculty(
                                  data.id,
                                  branch,
                                  sections,
                                );
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.save,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          color: Color(0xFF1D2B64),
                        ),
                        FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: BorderSide(
                              color: Color(0xFF1D2B64),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
