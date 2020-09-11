import 'package:dropdown_search/dropdown_search.dart';
import 'package:edwisely/data/blocs/assessmentLandingScreen/coursesBloc/courses_bloc.dart';
import 'package:edwisely/data/model/course/getAllCourses/data.dart';
import 'package:edwisely/ui/widgets_util/big_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

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
      body: BlocBuilder(
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
                                  hoverColor: Color(0xFF1D2B64).withOpacity(.2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    side: BorderSide(
                                      color: Color(0xFF1D2B64),
                                    ),
                                  ),
                                  onPressed: () => _showDialog(context,
                                      state.getAllCoursesEntity.data[index]),
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
    );
  }

  _showDialog(
    BuildContext context,
    Data data,
  ) =>
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder(
            cubit: context.bloc<CoursesBloc>().add(
                  GetSections(71),
                ),
            builder: (BuildContext context, state) {
              if (state is SectionsFetched) {
                return Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        'Which Department Do You Teach ? ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height / 50,
                        ),
                      ),
                      //todo get info for branch
                      MultiSelectChipDisplay(
                        items: ['CSE', 'ECE', 'MECH', 'CIVIL']
                            .map((e) => MultiSelectItem(e, e))
                            .toList(),
                      )
                    ],
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          );
        },
      );
}
