import 'package:chips_choice/chips_choice.dart';
import 'package:dio/dio.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/cubits/deck_items_cubit.dart';
import 'package:edwisely/data/model/course/courseContent/learning_content.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:toast/toast.dart';

import '../../../../data/api/api.dart';
import '../../../../data/cubits/add_faculty_content_cubit.dart';
import '../../../../data/cubits/course_content_cubit.dart';
import '../../../../data/cubits/get_course_decks_cubit.dart';
import '../../../../data/cubits/topic_cubit.dart';
import '../../../../data/cubits/unit_cubit.dart';
import '../../../../data/model/questionBank/topicEntity/data.dart';
import '../../../widgets_util/text_input.dart';

//doing this page
class CourseDetailCourseContentTab extends StatefulWidget {
  final int semesterId;
  final int subjectId;

  CourseDetailCourseContentTab(this.semesterId, this.subjectId);

  @override
  _CourseDetailCourseContentTabState createState() => _CourseDetailCourseContentTabState();
}

class _CourseDetailCourseContentTabState extends State<CourseDetailCourseContentTab>
    with SingleTickerProviderStateMixin {
  int enabledUnitId;
  int questionDropDownValue = 1;
  String typeDropDownValue = 'All';
  int levelDropDownValue = -1;
  PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: BlocProvider.of<AddFacultyContentCubit>(context),
      listener: (BuildContext context, state) {
        if (state is AddFacultyContentAdded) {
          Toast.show('Your Content Added', context);
          context
              .bloc<CourseContentCubit>()
              .getFacultyAddedCourseContent(enabledUnitId, widget.semesterId);
        }
        if (state is AddFacultyContentFailed) {
          Toast.show(state.error, context);
        }
      },
      child: Row(
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
                    // FIXME: 10/2/2020 change to state.units.data[0].id
                    723);
                enabledUnitId = state.units.data[0].id;
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
                            alignment: Alignment.center,
                            child: Text(
                              state.units.data[index].name,
                              style: enabledUnitId == state.units.data[index].id
                                  ? TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    )
                                  : TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal,
                                    ),
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
                                  itemBuilder: (BuildContext context, int index) => GestureDetector(
                                    onTap: () {
                                      context.bloc<DeckItemsCubit>().getDeckItems(
                                            state.courseDeckEntity.data[index].id,
                                          );
                                      return _showDeckItems(context);
                                    },
                                    child: GridTile(
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
                      onPressed: () => _showDialog(context, CourseContentAddType.adding),
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
                                    StatefulBuilder(
                                      builder: (BuildContext context, StateSetter setState) {
                                        return Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Type'),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
                                                  // width: MediaQuery.of(context).size.width * 0.05,
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 12.0,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(4.0),
                                                    border: Border.all(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  child: DropdownButton(
                                                    underline: SizedBox.shrink(),
                                                    items: [
                                                      DropdownMenuItem(
                                                        child: Text('All'),
                                                        value: 'All',
                                                      ),
                                                      DropdownMenuItem(
                                                        child: Text('Documents'),
                                                        value: 'DOCS',
                                                      ),
                                                      DropdownMenuItem(
                                                        child: Text('Videos'),
                                                        value: 'MP4',
                                                      ),
                                                      DropdownMenuItem(
                                                        child: Text('PPT'),
                                                        value: 'PPT',
                                                      ),
                                                      DropdownMenuItem(
                                                        child: Text('Other Links'),
                                                        value: 'URL',
                                                      ),
                                                    ],
                                                    onChanged: (value) => context
                                                        .bloc<CourseContentCubit>()
                                                        .getDocumentWiseData(
                                                          value,
                                                          state.backup,
                                                        ),
                                                    value: typeDropDownValue,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Level'),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
                                                  // width: MediaQuery.of(context).size.width * 0.05,
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 12.0,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(
                                                      4.0,
                                                    ),
                                                    border: Border.all(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  child: DropdownButton(
                                                    underline: SizedBox.shrink(),
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
                                                    onChanged: (value) => context
                                                        .bloc<CourseContentCubit>()
                                                        .getLevelWiseData(
                                                          value,
                                                          state.backup,
                                                        ),
                                                    value: levelDropDownValue,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Questions'),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
                                                  // width: MediaQuery.of(context).size.width * 0.05,
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 12.0,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(
                                                      4.0,
                                                    ),
                                                    border: Border.all(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  child: DropdownButton(
                                                    underline: SizedBox.shrink(),
                                                    items: [
                                                      DropdownMenuItem(
                                                        child: Text('All Questions'),
                                                        value: 1,
                                                      ),
                                                      DropdownMenuItem(
                                                        child: Text('Bookmarked'),
                                                        value: 2,
                                                      ),
                                                      DropdownMenuItem(
                                                        child: Text('Your Content'),
                                                        value: 3,
                                                      ),
                                                    ],
                                                    onChanged: (value) {
                                                      setState(() => questionDropDownValue = value);

                                                      switch (value) {
                                                        case 1:
                                                          context
                                                              .bloc<CourseContentCubit>()
                                                              .getCourseContent(
                                                                  enabledUnitId, widget.semesterId);
                                                          break;
                                                        case 2:
                                                          context
                                                              .bloc<CourseContentCubit>()
                                                              .getFacultyBookmarkedCourseContent(
                                                                  enabledUnitId, widget.semesterId);
                                                          break;
                                                        case 3:
                                                          context
                                                              .bloc<CourseContentCubit>()
                                                              .getFacultyAddedCourseContent(
                                                                  enabledUnitId, widget.semesterId);
                                                          break;
                                                      }
                                                    },
                                                    value: questionDropDownValue,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    SizedBox(height: 22.0),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: state.data.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        String level = '';
                                        switch (state.data[index].level) {
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
                                                    state.data[index].title ?? '',
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 30,
                                                ),
                                                state.data[index].level == -1 ||
                                                        state.data[index].level == null
                                                    ? Container()
                                                    : Text('Level - $level '),
                                                SizedBox(
                                                  width: 30,
                                                ),
                                                state.data[index].readtime == 0 ||
                                                        state.data[index].readtime == null
                                                    ? Container()
                                                    : Text(
                                                        'ReadingTime - ${state.data[index].readtime}'),
                                              ],
                                            ),
                                            subtitle: Text(
                                              'Source - ${state.data[index].source ?? ''}',
                                            ),
                                            trailing: PopupMenuButton(
                                              onSelected: (string) {
                                                switch (string) {
                                                  case 'Bookmark':
                                                    _bookmark(state.data[index]);
                                                    break;
                                                  case 'Delete':
                                                    _delete(state.data[index]);
                                                    break;
                                                  case 'Edit':
                                                    _showDialog(
                                                        context, CourseContentAddType.editing,
                                                        data: state.data[index]);
                                                  // case 'Change Type':
                                                  //   _changeType(state.data[index]);
                                                  //   break;
                                                }
                                              },
                                              itemBuilder: (context) {
                                                return [
                                                  'Edit',
                                                  'Bookmark',
                                                  'Delete',
                                                ] // 'Change Type to ${state.data[index].display_type == 'public' ? 'Private' : 'Public'}']
                                                    .map(
                                                      (e) => PopupMenuItem(
                                                        child: Text(e),
                                                        value: e,
                                                      ),
                                                    )
                                                    .toList();
                                              },
                                            ));
                                      },
                                    ),
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
      ),
    );
  }

  Future<void> _bookmark(Learning_content data) async {
    //going the easy way allah maaf kre
    bool isBookmarked = data.bookmarked == 1;
    if (isBookmarked) {
      final response = await EdwiselyApi.dio.post(
        'deleteBookmark',
        data: FormData.fromMap(
          {
            'type': data.type,
            'id': data.topic_id,
          },
        ),
      );
      print(response.data);
      if (response.data['message'] == 'Successfully deleted the bookmark') {
        setState(
          () => isBookmarked = false,
        );
      } else {
        Toast.show('Some Error Occurred', context);
      }
    } else {
      final response = await EdwiselyApi.dio.post(
        'addBookmark',
        data: FormData.fromMap(
          {
            'type': data.type,
            'id': data.topic_id,
          },
        ),
      );
      print(response.data);

      if (response.data['message'] == 'Successfully added the bookmark') {
        setState(
          () => isBookmarked = true,
        );
      } else {
        Toast.show('Some Error Occurred', context);
      }
    }
  }

  void _delete(Learning_content data) async {
    final response = await EdwiselyApi.dio.post(
      'units/deleteMaterial',
      data: FormData.fromMap(
        {'topic_id': data.topic_id, 'material_id': data.material_id},
      ),
    );
    if (response.data['message'] == 'Successfully deleted the files.') {
      setState(() {});
    } else {
      print(response.data);
      Toast.show('Cannot delete the item . PLease try again', context);
    }
  }

  _showDialog(BuildContext context, CourseContentAddType adding, {Learning_content data}) {
    bool isAdding = adding == CourseContentAddType.adding;
    showDialog(
      context: context,
      builder: (context) {
        String typeDropDownValue = isAdding ? 'All' : data.type;
        TextEditingController titleController = TextEditingController();
        if (!isAdding) {
          titleController.text = data.title;
        }
        String topic;
        bool isPublic = isAdding ? true : data.display_type == 'public';
        FilePickerCross file;
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.7,
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Type'),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          // width: MediaQuery.of(context).size.width * 0.05,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: DropdownButton(
                            underline: SizedBox.shrink(),
                            items: [
                              DropdownMenuItem(
                                child: Text('All'),
                                value: 'All',
                              ),
                              DropdownMenuItem(
                                child: Text('Documents'),
                                value: 'DOCS',
                              ),
                              DropdownMenuItem(
                                child: Text('Videos'),
                                value: 'MP4',
                              ),
                              DropdownMenuItem(
                                child: Text('PPT'),
                                value: 'PPT',
                              ),
                              DropdownMenuItem(
                                child: Text('Other Links'),
                                value: 'URL',
                              ),
                            ],
                            onChanged: (value) {
                              setState(() => typeDropDownValue = value);
                            },
                            value: typeDropDownValue,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Attachment'),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          icon: Icon(file == null ? Icons.add : Icons.save),
                          onPressed: () async {
                            file = await FilePickerCross.importFromStorage(
                              type: FileTypeCross.any,
                            );
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 32.0),
                    TextInput(
                      label: 'Title',
                      hint: 'Enter Your Content\'s Title',
                      inputType: TextInputType.text,
                      controller: titleController,
                    ),
                    SizedBox(height: 32.0),
                    BlocBuilder(
                      cubit: context.bloc<TopicCubit>()..getTopics(widget.subjectId),
                      builder: (BuildContext context, state) {
                        if (state is TopicFetched) {
                          return ChipsChoice<String>.single(
                            value: topic,
                            isWrapped: true,
                            options: ChipsChoiceOption.listFrom(
                              source: state.topicEntity.data,
                              value: (i, Data v) => v.code,
                              label: (i, Data v) => v.name,
                            ),
                            onChanged: (val) {
                              setState(
                                () => topic = val,
                              );
                            },
                          );
                        }
                        if (state is TopicEmpty) {
                          return Text('No topcis to Tag');
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    Container(
                      width: 180,
                      padding: const EdgeInsets.only(top: 32.0),
                      child: SwitchListTile(
                        title: Text(
                          'Make Public',
                        ),
                        value: isPublic,
                        onChanged: (flag) {
                          setState(
                            () => isPublic = flag,
                          );
                        },
                      ),
                    ),
                    // FIXME: 9/27/2020
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton.icon(
                          onPressed: () {
                            if (typeDropDownValue.isEmpty ||
                                file.path.isEmpty ||
                                titleController.text.isEmpty ||
                                topic.isEmpty) {
                              Toast.show('Please Check contents once', context);
                            } else {
                              if (isAdding) {
                                BlocProvider.of<AddFacultyContentCubit>(context).addFacultyContent(
                                    enabledUnitId,
                                    topic,
                                    1,
                                    titleController.text,
                                    file,
                                    isPublic ? 'public' : 'private',
                                    'externalUrl');
                              } else {
                                BlocProvider.of<AddFacultyContentCubit>(context)
                                    .updateFacultyContent(
                                        int.parse(data.topic_id),
                                        int.parse(data.type),
                                        data.material_id,
                                        titleController.text,
                                        attachments: file);
                              }
                            }
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

// FIXME: 10/7/2020 error hai nhi ho rha
  _showDeckItems(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => BlocBuilder(
        cubit: context.bloc<DeckItemsCubit>(),
        builder: (BuildContext context, state) {
          if (state is DeckItemsFetched) {
            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: state.deckItemsEntity.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      print('sdvs');
                      return FutureBuilder(
                        future: Dio().get(state.deckItemsEntity.data[0].url),
                        builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
                          if (snapshot.hasData) {
                            String dd = snapshot.data.data.toString().replaceAll('\$', '\$\$');
                            return Card(
                              margin: EdgeInsets.all(150),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: TeXView(
                                  renderingEngine: TeXViewRenderingEngine.mathjax(),
                                  loadingWidgetBuilder: (context) => CircularProgressIndicator(),
                                  child: TeXViewDocument(dd),
                                ),
                              ),
                            );
                          } else {
                            return Material(
                              child: Text('Loading...'),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RaisedButton.icon(
                        onPressed: () {
                          return pageController.previousPage(
                              duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                        },
                        icon: Icon(Icons.chevron_left),
                        label: Text(
                          'Previous',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      RaisedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close),
                        label: Text(
                          'Close',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      RaisedButton.icon(
                        onPressed: () => pageController.nextPage(
                            duration: Duration(milliseconds: 500), curve: Curves.easeIn),
                        icon: Icon(Icons.chevron_right),
                        label: Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              ],
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
}

enum CourseContentAddType { editing, adding }
