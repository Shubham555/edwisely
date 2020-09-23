import 'package:edwisely/data/blocs/coursesBloc/courses_bloc.dart';
import 'package:edwisely/data/cubits/unit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseDetailCourseContentTab extends StatelessWidget {
  final int semesterId;

  CourseDetailCourseContentTab(this.semesterId);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder(
          cubit: context.bloc<UnitCubit>()
            ..getUnitsOfACourse(
              semesterId,
            ),
          builder: (BuildContext context, state) {
            if (state is CourseUnitFetched) {
              int enabledUnitId = state.units.data[0].id;
              return Container(
                width: MediaQuery.of(context).size.width / 7,
                child: StatefulBuilder(
                  builder: (BuildContext context,
                      void Function(void Function()) setState) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.units.data.length,
                      itemBuilder: (BuildContext context, int index) =>
                          ListTile(
                        hoverColor: Colors.white,
                        selected: enabledUnitId == state.units.data[index].id,
                        title: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: enabledUnitId == state.units.data[index].id
                                ? Theme.of(context).primaryColor
                                : Colors.transparent,
                            boxShadow: [
                              BoxShadow(
                                blurRadius:
                                    enabledUnitId == state.units.data[index].id
                                        ? 6.0
                                        : 0,
                                color:
                                    enabledUnitId == state.units.data[index].id
                                        ? Colors.black.withOpacity(0.3)
                                        : Colors.transparent,
                              ),
                            ],
                          ),
                          child: Text(
                            state.units.data[index].name,
                            style: TextStyle(
                                color:
                                    enabledUnitId == state.units.data[index].id
                                        ? Colors.white
                                        : Theme.of(context).primaryColor,
                                fontSize:
                                    enabledUnitId == state.units.data[index].id
                                        ? 25
                                        : null),
                          ),
                        ),
                        onTap: () {
                          enabledUnitId = state.units.data[index].id;

                          setState(
                            () {},
                          );
                          context.bloc<CoursesBloc>().add(
                                GetCourseContentData(
                                  state.units.data[index].id,
                                ),
                              );
                        },
                      ),
                    );
                  },
                ),
              );
            } else {
              return Container();
            }
          },
        ),
        BlocBuilder(
          cubit: context.bloc<CoursesBloc>()..add(GetCourseContentData(2)),
          builder: (BuildContext context, state) {
            if (state is CourseContentDataFetched) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * (3.5 / 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Learning Snippets',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.height / 50,
                              ),
                            ),
                            FlatButton(
                              hoverColor: Color(0xFF1D2B64).withOpacity(.2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                                side: BorderSide(
                                  color: Color(0xFF1D2B64),
                                ),
                              ),
                              onPressed: () => null,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Color(0xFF1D2B64),
                                  ),
                                  Text(
                                    'Add Your Deck',
                                    style: TextStyle(
                                      color: Color(0xFF1D2B64),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * (3.5 / 5),
                        height: 300,
                        child: GridView.builder(
                          itemCount: state.courseDeckEntity.data.length,
                          itemBuilder: (BuildContext context, int index) =>
                              GridTile(
                            child: state.courseDeckEntity.data[index].image ==
                                    ''
                                ? Center(
                                    child: Icon(
                                      Icons.book,
                                      size: 60,
                                    ),
                                  )
                                : Image.network(
                                    state.courseDeckEntity.data[index].image,
                                    width: 150,
                                    height: 200,
                                  ),
                            footer: Container(
                              width: 150,
                              child: Text(
                                state.courseDeckEntity.data[index].name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            crossAxisCount: 1,
                          ),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            if (state is CoursesFetchFailed) {
              return Center(
                child: Text('There was some error'),
              );
            }
            if (state is CoursesEmpty) {
              return Center(
                child: Text('No Decks were found for this unit'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    );
  }
}
