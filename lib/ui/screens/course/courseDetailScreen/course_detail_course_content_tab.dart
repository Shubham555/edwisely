import 'package:edwisely/data/cubits/course_content_cubit.dart';
import 'package:edwisely/data/cubits/get_course_decks_cubit.dart';
import 'package:edwisely/data/cubits/unit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//doing this page
class CourseDetailCourseContentTab extends StatefulWidget {
  final int semesterId;

  CourseDetailCourseContentTab(this.semesterId);

  @override
  _CourseDetailCourseContentTabState createState() => _CourseDetailCourseContentTabState();
}

class _CourseDetailCourseContentTabState extends State<CourseDetailCourseContentTab> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listViewSeperationWidth = MediaQuery.of(context).size.width * 0.05;
    print(widget.semesterId);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        BlocBuilder(
          cubit: context.bloc<UnitCubit>()
            ..getUnitsOfACourse(
              widget.semesterId,
            ),
          builder: (BuildContext context, state) {
            if (state is CourseUnitFetched) {
              context.bloc<CourseContentCubit>().getCourseContent(
                    state.units.data[0].id,
                    widget.semesterId,
                  );
              context.bloc<CourseDecksCubit>().getCourseDecks(
                    state.units.data[0].id,
                  );
              int enabledUnitId = state.units.data[0].id;
              return Container(
                width: MediaQuery.of(context).size.width / 7,
                child: StatefulBuilder(
                  builder: (BuildContext context, void Function(void Function()) setState) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.units.data.length,
                      itemBuilder: (BuildContext context, int index) => ListTile(
                        hoverColor: Colors.white,
                        selected: enabledUnitId == state.units.data[index].id,
                        title: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: enabledUnitId == state.units.data[index].id ? Theme.of(context).primaryColor : Colors.transparent,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: enabledUnitId == state.units.data[index].id ? 6.0 : 0,
                                color: enabledUnitId == state.units.data[index].id ? Colors.black.withOpacity(0.3) : Colors.transparent,
                              ),
                            ],
                          ),
                          child: Text(
                            state.units.data[index].name,
                            style: TextStyle(
                                color: enabledUnitId == state.units.data[index].id ? Colors.white : Theme.of(context).primaryColor,
                                fontSize: enabledUnitId == state.units.data[index].id ? 25 : null),
                          ),
                        ),
                        onTap: () {
                          enabledUnitId = state.units.data[index].id;
                          print(enabledUnitId);
                          setState(
                            () {},
                          );
                          context.bloc<CourseContentCubit>().getCourseContent(
                                state.units.data[index].id,
                                widget.semesterId,
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
        Expanded(
          child: Column(
            children: [
              BlocBuilder(
                cubit: context.bloc<CourseDecksCubit>(),
                builder: (BuildContext context, state) {
                  if (state is CourseDecksFetched) {
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
                                      fontSize: MediaQuery.of(context).size.height / 50,
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
                                itemBuilder: (BuildContext context, int index) => GridTile(
                                  child: state.courseDeckEntity.data[index].image == ''
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
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                  if (state is CoursesDeckFetchFailed) {
                    return Center(
                      child: Text('There was some error'),
                    );
                  }
                  if (state is CoursesDeckEmpty) {
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
              Expanded(
                child: BlocBuilder(
                  cubit: context.bloc<CourseContentCubit>(),
                  builder: (BuildContext context, state) {
                    if (state is CourseContentFetched) {
                      return Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Curated Content',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context).size.height / 50,
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
                                              'Add Your Content',
                                              style: TextStyle(
                                                color: Color(0xFF1D2B64),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  StatefulBuilder(
                                    builder: (BuildContext context, void Function(void Function()) setState) {
                                      String typeDropDownValue = 'All';
                                      int levelDropDownValue = -1;
                                      return Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text('Type'),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              DropdownButton(
                                                items: [
                                                  DropdownMenuItem(
                                                    child: Text('All'),
                                                    value: 'All',
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text('Documents'),
                                                    value: 'DOC',
                                                  ),
                                                  //todo get type value for videos
                                                  DropdownMenuItem(
                                                    child: Text('Videos'),
                                                    value: 'VID',
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text('PPT'),
                                                    value: 'PPT',
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text('Other Links'),
                                                    value: 'DOC',
                                                  ),
                                                ],
                                                onChanged: (value) => null,
                                                value: typeDropDownValue,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Row(
                                            children: [
                                              Text('Level'),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              DropdownButton(
                                                items: [
                                                  DropdownMenuItem(
                                                    child: Text('All'),
                                                    value: -1,
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text('Easy'),
                                                    value: 1,
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text('Medium'),
                                                    value: 2,
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text('Hard'),
                                                    value: 3,
                                                  ),
                                                ],
                                                onChanged: (value) => null,
                                                value: levelDropDownValue,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Expanded(
                                            child: TabBar(
                                              labelColor: Theme.of(context).primaryColor,
                                              labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                              unselectedLabelStyle: TextStyle(color: Colors.black),
                                              tabs: [
                                                Tab(
                                                  child: Text('All'),
                                                ),
                                                Tab(
                                                  child: Text('Bookmarked'),
                                                ),
                                                Tab(
                                                  child: Text('Your Content'),
                                                ),
                                              ],
                                              controller: tabController,
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state.courseContentEntity.academic_materials.length,
                                    itemBuilder: (BuildContext context, int index) => ListTile(
                                      leading: Icon(Icons.android),
                                      title: Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width / 7,
                                            child: Text(
                                              state.courseContentEntity.academic_materials[index].title ?? '',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Container(width: MediaQuery.of(context).size.width / 7, child: Text('Level - NA')),
                                          Text('ReadingTime - NA'),
                                        ],
                                      ),
                                      subtitle: Visibility(
                                        visible: state.courseContentEntity.academic_materials[index].source != '',
                                        child: Text(
                                          'Source - ${state.courseContentEntity.academic_materials[index].source}',
                                        ),
                                      ),
                                      trailing: Icon(
                                        state.courseContentEntity.academic_materials[index].bookmarked == 0 ? Icons.bookmark_border : Icons.bookmark,
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state.courseContentEntity.learning_content.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      String level = '';
                                      switch (state.courseContentEntity.learning_content[index].level) {
                                        case -1:
                                          level = 'N/A';
                                          break;
                                        case 1:
                                          level = 'Easy';
                                          break;
                                        case 2:
                                          level = 'Medium';
                                          break;
                                        case 3:
                                          level = 'Hard';
                                          break;
                                      }
                                      return ListTile(
                                        leading: Icon(Icons.android),
                                        title: Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width / 7,
                                              child: Text(
                                                state.courseContentEntity.learning_content[index].title ?? '',
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Container(width: MediaQuery.of(context).size.width / 7, child: Text('Level - $level ')),
                                            Text('ReadingTime - ${state.courseContentEntity.learning_content[index].readtime}'),
                                          ],
                                        ),
                                        subtitle: Text(
                                          'Source - ${state.courseContentEntity.learning_content[index].source ?? ''}',
                                        ),
                                        trailing: Icon(
                                          state.courseContentEntity.learning_content[index].bookmarked == 0 ? Icons.bookmark_border : Icons.bookmark,
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    if (state is CourseContentFailed) {
                      return Center(
                        child: Text(state.error),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
