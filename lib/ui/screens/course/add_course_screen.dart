import 'package:auto_size_text/auto_size_text.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:edwisely/data/cubits/department_cubit.dart';
import 'package:edwisely/data/model/course/getAllCourses/GetAllCoursesEntity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../../data/blocs/coursesBloc/courses_bloc.dart';
import '../../../data/cubits/add_course_cubit.dart';
import '../../../data/model/course/getAllCourses/data.dart';
import '../../../data/model/course/getAllCourses/departments.dart';
import '../../../data/model/course/sectionEntity/SectionEntity.dart';
import '../../../data/model/course/sectionEntity/data.dart' as sectionDta;
import '../../../data/provider/selected_page.dart';
import '../../widgets_util/big_app_bar.dart';
import '../../widgets_util/navigation_drawer.dart';

class AddCourseScreen extends StatefulWidget {
  @override
  _AddCourseScreenState createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  GetAllCoursesEntity coursesFilter;
  int selectedDropDown;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Provider.of<SelectedPageProvider>(context, listen: false).setPreviousIndex();
        return true;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Center(
            child: BlocListener(
              cubit: context.bloc<AddCourseCubit>(),
              listener: (BuildContext context, state) {
                if (state is CourseAdded) {
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Course Added Successfully')));
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
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.error)));
                  Future.delayed(Duration(seconds: 2), () {
                    // Navigator.pop(context);
                    // Navigator.pop(context);
                    // Provider.of<SelectedPageProvider>(context, listen: false).setPreviousIndex ();
                  });
                }
              },
              child: Row(
                children: [
                  NavigationDrawer(
                    isCollapsed: MediaQuery.of(context).size.width <= 1366 ? true : false,
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
                          appBarSize: MediaQuery.of(context).size.height / 3.5,
                          appBarTitle: Text('Edwisely'),
                          flatButton: null,
                          route: 'Home > All Courses > Add Courses',
                        ).build(context),
                        BlocBuilder(
                          cubit: context.bloc<CoursesBloc>()
                            ..add(
                              GetAllCourses(),
                            ),
                          builder: (BuildContext context, outerState) {
                            if (outerState is AllCoursesFetched) {
                              if (coursesFilter == null) {
                                coursesFilter = outerState.getAllCoursesEntity;
                                coursesFilter.data = List.unmodifiable(outerState.getAllCoursesEntity.data);
                              }
                              return Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16.0,
                                        horizontal: MediaQuery.of(context).size.width * 0.17,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width / 5,
                                            child: TypeAheadField(
                                              textFieldConfiguration: TextFieldConfiguration(
                                                style: DefaultTextStyle.of(context).style.copyWith(
                                                      fontStyle: FontStyle.normal,
                                                    ),
                                                decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Search Courses'),
                                              ),
                                              suggestionsCallback: (searchString) async {
                                                List<Data> courses = List();
                                                courses.addAll(outerState.getAllCoursesEntity.data);
                                                courses.retainWhere(
                                                  (element) => element.name.toLowerCase().contains(
                                                        searchString.toLowerCase(),
                                                      ),
                                                );
                                                return courses;
                                              },
                                              itemBuilder: (context, Data data) {
                                                return ListTile(
                                                  title: Text(data.name),
                                                );
                                              },
                                              onSuggestionSelected: (data) => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (BuildContext context) => _showDialog(
                                                    context,
                                                    data,
                                                    data.departments,
                                                    outerState.sectionEntity,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 32.0),
                                          BlocBuilder(
                                            cubit: context.bloc<DepartmentCubit>()..getDepartments(),
                                            builder: (BuildContext context, state) {
                                              if (state is DepartmentFetched) {
                                                // selectedDropDown = state.departmentEntity.data[0].department_id;
                                                return StatefulBuilder(
                                                  builder: (BuildContext context, StateSetter setState) => Container(
                                                    padding: const EdgeInsets.symmetric(
                                                      vertical: 6.0,
                                                      horizontal: 16.0,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(4.0),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    child: DropdownButton(
                                                      value: selectedDropDown,
                                                      hint: Text('Select Department',),
                                                      underline: SizedBox.shrink(),
                                                      items: List.generate(
                                                        state.departmentEntity.data.length,
                                                        (index) => DropdownMenuItem(
                                                          child: Text(
                                                            state.departmentEntity.data[index].department,
                                                          ),
                                                          value: state.departmentEntity.data[index].department_id,
                                                        ),
                                                      ),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedDropDown = value;
                                                        });
                                                        // context.bloc<CoursesBloc>().add(SortCourses(value, coursesFilter));
                                                      },
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return Center(
                                                  child: CircularProgressIndicator(),
                                                );
                                              }
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 16.0,
                                          horizontal: MediaQuery.of(context).size.width * 0.17,
                                        ),
                                        child: GridView.builder(
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            mainAxisSpacing: 35,
                                            crossAxisSpacing: 35,
                                            crossAxisCount: 3,
                                            childAspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.height / 2.6,
                                          ),
                                          itemBuilder: (BuildContext context, int index) {
                                            return Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                  6,
                                                ),
                                              ),
                                              elevation: 6,
                                              child: _buildCourseTile(index, context, outerState.getAllCoursesEntity.data, outerState),
                                            );
                                          },
                                          itemCount: outerState.getAllCoursesEntity.data.length,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            if (outerState is CourseAdded) {
                              return Column(
                                children: [
                                  CircularProgressIndicator(),
                                  Text('Course Added '),
                                ],
                              );
                            } else {
                              return Expanded(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCourseTile(int upperIndex, BuildContext context, List<Data> courses, state) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: MediaQuery.of(context).size.height / 5,
              child: courses[upperIndex].course_image == ''
                  ? Image.asset(
                      'placeholder_image.jpg',
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width / 4,
                    )
                  : Image.network(
                      courses[upperIndex].course_image,
                    ),
            ),
          ),
          SizedBox(height: 12.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: MediaQuery.of(context).size.height * 0.0001),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
              width: double.infinity,
              child: AutoSizeText(
                courses[upperIndex].name,
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
                  courses[upperIndex].departments.length,
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
                      courses[upperIndex].departments[index].name,
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
                    courses[upperIndex],
                    courses[upperIndex].departments,
                    state.sectionEntity,
                  ),
                  padding: const EdgeInsets.all(0),
                  color: Theme.of(context).primaryColor,
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
          builder: (BuildContext context, void Function(void Function()) setState) {
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



                            if (branch == null || sections.isEmpty) {
                              Toast.show('Please select at least one section and one department', context, duration: 4);
                            }
                            outerContext.bloc<AddCourseCubit>().addCourseToFaculty(
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
                          color: Theme.of(context).primaryColor,
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
