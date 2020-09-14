import 'package:edwisely/data/blocs/coursesBloc/courses_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseDetailCourseContentTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                'Learning Snippets',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.height / 50,
                                ),
                              ),
                              Divider(
                                thickness: 2,
                              )
                            ],
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
                      // List.generate(
                      //   state.courseDeckEntity.data.length,
                      //       (index) => Card(
                      //     child: Stack(
                      //       children: [
                      //         state.courseDeckEntity.data[index].image == ''
                      //             ? Icon(
                      //           Icons.book,
                      //           size: 60,
                      //         )
                      //             : Image.network(
                      //           state.courseDeckEntity.data[index].image,
                      //           width: 150,
                      //           height: 200,
                      //         ),
                      //         Container(
                      //           decoration: BoxDecoration(
                      //             gradient: LinearGradient(
                      //                 colors: [
                      //                   Colors.black,
                      //                   Colors.transparent,
                      //                 ],
                      //                 begin: Alignment.bottomCenter,
                      //                 stops: [0, .3],
                      //                 end: Alignment.topCenter),
                      //           ),
                      //         ),
                      //         Positioned(
                      //           left: 15,
                      //           bottom: 15,
                      //           child: Text(
                      //             state.courseDeckEntity.data[index].name,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // )
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
        )
      ],
    );
  }
}
