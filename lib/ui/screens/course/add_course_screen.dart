import 'package:chips_choice/chips_choice.dart';
import 'package:edwisely/data/blocs/coursesBloc/courses_bloc.dart';
import 'package:edwisely/data/model/course/getAllCourses/data.dart';
import 'package:edwisely/data/model/course/getAllCourses/departments.dart';
import 'package:edwisely/data/model/course/sectionEntity/SectionEntity.dart';
import 'package:edwisely/data/model/course/sectionEntity/data.dart'
    as sectionDta;
import 'package:edwisely/ui/widgets_util/big_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

class AddCourseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BigAppBar(
              actions: null,
              titleText: 'Add Courses',
              bottomTab: null,
              appBarSize: MediaQuery.of(context).size.height / 3.5,
              appBarTitle: Text('Edwisely'),
              flatButton: null)
          .build(context),
      body: BlocListener(
        cubit: context.bloc<CoursesBloc>(),
        listener: (BuildContext context, state) {
          if (state is CourseAdded) {
            Navigator.pop(context);
          }
        },
        child: BlocBuilder(
          cubit: context.bloc<CoursesBloc>()..add(GetAllCourses()),
          builder: (BuildContext context, state) {
            if (state is AllCoursesFetched) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Course That You Teach',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height / 50,
                      ),
                    ),
                    //todo add search implementation

                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Wrap(
                            runSpacing: 30,
                            spacing: 30,
                            children: List.generate(
                              state.getAllCoursesEntity.data.length,
                              (index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 150,
                                    height: 150,
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          state.getAllCoursesEntity.data[index]
                                              .name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                50,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  FlatButton.icon(
                                    hoverColor:
                                        Color(0xFF1D2B64).withOpacity(.2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      side: BorderSide(
                                        color: Color(0xFF1D2B64),
                                      ),
                                    ),
                                    onPressed: () => _showDialog(
                                      context,
                                      state.getAllCoursesEntity.data[index],
                                      state.getAllCoursesEntity.data[index]
                                          .departments,
                                      state.sectionEntity,
                                    ),
                                    icon: Icon(Icons.add),
                                    label: Text('Add'),
                                  )
                                ],
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
                            print('dep : $branch');
                            print('sec : $sections');
                            print('subjec : ${data.id}');
                            if (branch == null || sections.isEmpty) {
                              Toast.show(
                                  'Please select atleast one section and one department',
                                  context,
                                  duration: 4);
                            }
                            outerContext.bloc<CoursesBloc>().add(
                                  AddCourseToFaculty(
                                    data.id,
                                    branch,
                                    sections,
                                  ),
                                );
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
