import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/provider/selected_page.dart';
import '../../../widgets_util/big_app_bar.dart';
import '../../../widgets_util/navigation_drawer.dart';
import 'course_detail_about_tab.dart';
import 'course_detail_course_content_tab.dart';
import 'course_detail_question_bank_tab.dart';
import 'course_detail_syllabus_tab.dart';

class CourseDetailScreen extends StatefulWidget {
  final String _courseName;
  final int semesterSubjectId;
  final int subjectId;

  CourseDetailScreen(this._courseName, this.semesterSubjectId, this.subjectId);

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  bool _isCollapsed = true;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _tabController.index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationDrawer(
            isCollapsed: _isCollapsed,
            key: context.watch<SelectedPageProvider>().navigatorKey,
          ),
          Expanded(
            child: Column(
              children: [
                BigAppBar(
                  actions: null,
                  titleText: widget._courseName,
                  appBarSize: MediaQuery.of(context).size.height / 3,
                  bottomTab: null,
                  appBarTitle: Text(
                    'Edwisely',
                    style: TextStyle(color: Colors.black),
                  ),
                  flatButton: null,
                  route: 'Home > All Courses > Course Details',
                ).build(context),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: MediaQuery.of(context).size.width * 0.17,
                        ),
                        child: TabBar(
                          labelPadding: EdgeInsets.symmetric(horizontal: 36.0),
                          indicatorColor: Theme.of(context).primaryColor,
                          labelColor: Colors.black,
                          indicatorPadding: const EdgeInsets.only(top: 4.0),
                          unselectedLabelColor: Colors.grey,
                          unselectedLabelStyle:
                              Theme.of(context).textTheme.headline6,
                          labelStyle:
                              Theme.of(context).textTheme.headline5.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                          isScrollable: true,
                          controller: _tabController,
                          tabs: [
                            Tab(
                              text: 'About',
                            ),
                            Tab(
                              text: 'Syllabus',
                            ),
                            Tab(
                              text: 'Course Content',
                            ),
                            Tab(
                              text: 'Question Bank',
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.17,
                          ),
                          child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            controller: _tabController,
                            children: [
                              CourseDetailAboutTab(
                                widget.semesterSubjectId,
                              ),
                              CourseDetailSyllabusTab(
                                widget.semesterSubjectId,
                              ),
                              CourseDetailCourseContentTab(
                                widget.semesterSubjectId,
                                widget.subjectId,
                              ),
                              CourseDetailQuestionBankTab(
                                  widget.semesterSubjectId, widget.subjectId),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
