import 'package:edwisely/data/blocs/coursesBloc/courses_bloc.dart';
import 'package:edwisely/data/cubits/unit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseDetailCourseContentTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder(
          cubit: context.bloc<UnitCubit>(),
          builder: (BuildContext context, state) {
            if (state is CourseUnitFetched) {
              return Container(
                width: MediaQuery.of(context).size.width / 5,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.units.data.length,
                  itemBuilder: (BuildContext context, int index) => ListTile(
                    title: Text(state.units.data[index].name),
                    onTap: () => context.bloc<CoursesBloc>().add(
                          GetCourseContentData(
                            state.units.data[index].id,
                          ),
                        ),
                  ),
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
