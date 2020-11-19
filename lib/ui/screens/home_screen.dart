import 'package:dio/dio.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/cubits/home_screen_default_cubit.dart';
import 'package:edwisely/data/cubits/material_comment_cubit.dart';
import 'package:edwisely/data/model/NotifiacationHomeScreenEntity.dart';
import 'package:edwisely/data/model/PeersDataEntity.dart';
import 'package:edwisely/data/provider/selected_page.dart';
import 'package:edwisely/ui/screens/course/courseDetailScreen/course_detail_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;

import '../../main.dart';
import '../widgets_util/navigation_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Size screenSize;
  TextTheme textTheme;
  HomeScreenDefaultCubit homeScreenDefaultCubit;

  @override
  Widget build(BuildContext context) {
    homeScreenDefaultCubit = context.bloc<HomeScreenDefaultCubit>()
      ..getHomeScreenContent();
    screenSize = MediaQuery.of(context).size;
    textTheme = Theme.of(context).textTheme;

    Provider.of<SelectedPageProvider>(context, listen: false).changePage(0);

    return WillPopScope(
      onWillPop: () async {
        Provider.of<SelectedPageProvider>(context, listen: false)
            .setPreviousIndex();
        return true;
      },
      child: Scaffold(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //side bar
            NavigationDrawer(
              isCollapsed: screenSize.width <= 1366 ? true : false,
              isHome: false,
              isCollapsable: false,
            ),
            //rest of the screen
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //center part
                  SizedBox(
                    width: screenSize.width * 0.57,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 22.0,
                        left: 36.0,
                      ),
                      child: BlocBuilder(
                        cubit: homeScreenDefaultCubit,
                        builder: (BuildContext context, state) {
                          if (state is HomeScreenDefaultFetched) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //heading text
                                Text(
                                  'Your Courses',
                                  style: textTheme.headline2,
                                ),
                                //list of courses
                                _yourCoursesList(
                                  state.map['courses'],
                                ),
                                //spacing
                                SizedBox(height: 18.0),
                                //heading text
                                Text(
                                  'Activity Wall',
                                  style: textTheme.headline2,
                                ),
                                //activityWall
                                activityTabList(
                                  state.map['activity_tab'],
                                ),
                              ],
                            );
                          }
                          if (state is HomeScreenDefaultFailed) {
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
                    ),
                  ),
                  //right part
                  Padding(
                    padding: const EdgeInsets.only(top: 22.0, right: 42.0),
                    child: SizedBox(
                      width: screenSize.width * 0.22,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //heading text,
                          _upcomingEventsList(),
                          //spacing
                          SizedBox(
                            height: screenSize.height * 0.01,
                          ),
                          //heading text
                          _peerActivityList(),
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
    );
  }

  Widget _peerActivityList() {
    return FutureBuilder(
      future: EdwiselyApi.dio.get(
          'college/getPeersData?from_date=${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}&delta_days=50',
          options: Options(headers: {
            'Authorization': 'Bearer $loginToken',
          })),
      builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.data['college_notifications'].toString() == '[]') {
            return Container();
          } else {
            PeersDataEntity peersDataEntity =
                PeersDataEntity.fromJsonMap(snapshot.data.data);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Peer Activity',
                  style: textTheme.headline2,
                ),
                Container(
                  height: screenSize.height * 0.375,
                  margin: const EdgeInsets.only(
                    right: 22.0,
                    top: 12.0,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 18.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: peersDataEntity.college_notifications.length,
                    itemBuilder: (BuildContext context, int index) => ListTile(
                      title: Text(
                        peersDataEntity.college_notifications[index].title,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _peerActivityCard(String activity) {
    return ListTile(
      leading: Image.asset('assets/icons/peer.png'),
      title: Text(activity),
    );
  }

  Widget _upcomingEventsList() {
    return BlocBuilder(
      cubit: homeScreenDefaultCubit,
      builder: (BuildContext context, state) {
        if (state is HomeScreenDefaultFetched) {
          if (state.map['upcoming_events'].toString() ==
              '{objective_tests: [], subjective_tests: [], vc: []}') {
            return Container();
          } else
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upcoming',
                  style: textTheme.headline2,
                  textAlign: TextAlign.start,
                ),
                Container(
                  height: screenSize.height * 0.375,
                  width: screenSize.width * .25,
                  margin: const EdgeInsets.only(
                    right: 22.0,
                    top: 12.0,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 18.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      state.map['upcoming_events']['objective_tests'] == ''
                          ? Text('There are no objective test!')
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  List<NotifiacationHomeScreenEntity>.from(state
                                      .map['upcoming_events']['objective_tests']
                                      .map((it) => NotifiacationHomeScreenEntity
                                          .fromJsonMap(it))).length,
                              itemBuilder: (BuildContext context, int index) {
                                var data =
                                    List<NotifiacationHomeScreenEntity>.from(
                                        state
                                            .map['upcoming_events']
                                                ['objective_tests']
                                            .map((it) =>
                                                NotifiacationHomeScreenEntity
                                                    .fromJsonMap(it)));
                                return ListTile(
                                  title: Text(data[index].title),
                                );
                              },
                            ),
                      //for Suvbjective
                      state.map['upcoming_events']['subjective_tests'] == ''
                          ? Text('There are no objective test!')
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  List<NotifiacationHomeScreenEntity>.from(state
                                      .map['upcoming_events']
                                          ['subjective_tests']
                                      .map((it) => NotifiacationHomeScreenEntity
                                          .fromJsonMap(it))).length,
                              itemBuilder: (BuildContext context, int index) {
                                var data =
                                    List<NotifiacationHomeScreenEntity>.from(
                                        state
                                            .map['upcoming_events']
                                                ['subjective_tests']
                                            .map((it) =>
                                                NotifiacationHomeScreenEntity
                                                    .fromJsonMap(it)));
                                return ListTile(
                                  title: Text(data[index].title),
                                );
                              },
                            ),
                      // for video conference
                      state.map['upcoming_events']['vc'] == ''
                          ? Text('There are no objective test!')
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  List<NotifiacationHomeScreenEntity>.from(state
                                      .map['upcoming_events']['vc']
                                      .map((it) => NotifiacationHomeScreenEntity
                                          .fromJsonMap(it))).length,
                              itemBuilder: (BuildContext context, int index) {
                                var data =
                                    List<NotifiacationHomeScreenEntity>.from(
                                        state.map['upcoming_events']
                                                ['vc']
                                            .map((it) =>
                                                NotifiacationHomeScreenEntity
                                                    .fromJsonMap(it)));
                                return ListTile(
                                  title: Text(data[index].title),
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ],
            );
        }
        if (state is HomeScreenDefaultFailed) {
          return Center(
            child: Text(state.error),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget activityTabList(dynamic activityTab) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: activityTab.length,
        itemBuilder: (ctx, index) {
          switch (activityTab[index]['type']) {
            case 'Test':
              return _testActivity(activityTab[index]);
            case 'Notification':
              return _notificationActivity(activityTab[index]);
            case 'Feedback':
              return _feedbackActivity(activityTab[index]);
            case 'VideoConference':
              return _meetingActivity(activityTab[index]);
            case 'Material':
              return _testActivity(activityTab[index]);
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget _meetingActivity(dynamic activity) {
    return Container(
      width: screenSize.width * 0.24,
      margin: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 22.0,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 22.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6.0,
          )
        ],
      ),
      child: Column(
        children: [
          _activityTitle(
            activity['title'],
            Color(0xFF4ED8DA),
            activity['followers'],
            activity['start_time'],
          ),
          //center portion
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 22.0, horizontal: 32.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //left part
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //meeting title
                    Text(
                      activity['description'],
                      style: textTheme.headline5,
                    ),
                    //start time
                    Text.rich(
                      TextSpan(
                        text: 'Start Time:    ',
                        style: textTheme.headline6,
                        children: [
                          TextSpan(
                            text: activity['start_time'].toString(),
                            style: textTheme.headline6.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //end time
                    Text.rich(
                      TextSpan(
                        text: 'End Time:      ',
                        style: textTheme.headline6,
                        children: [
                          TextSpan(
                            text: activity['end_time'].toString(),
                            style: textTheme.headline6.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (DateTime.parse(activity['start_time']).isBefore(
                              DateTime.now().add(
                                Duration(
                                  minutes: 10,
                                ),
                              ),
                            ) &&
                            DateTime.parse(activity['start_time']).isAfter(
                              DateTime.now(),
                            )) {
                          return html.window.open(activity['url'], 'Meeting');
                        } else {
                          return null;
                        }
                      },
                      child:
                          Text(DateTime.parse(activity['start_time']).isAfter(
                        DateTime.now().add(
                          Duration(
                            minutes: 10,
                          ),
                        ),
                      )
                              ? 'Meeting Scheduled'
                              : DateTime.parse(activity['start_time']).isBefore(
                                  DateTime.now(),
                                )
                                  ? 'Meeting Completed'
                                  : 'Start Meeting'),
                    )
                  ],
                ),
              ],
            ),
          ),
          //footer
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //sendTo
              Image.asset('assets/icons/sendTo.png'),
              SizedBox(width: 6.0),
              //send count
              Text('${activity['sent_to']} Send To'),
              //spacing
              SizedBox(width: screenSize.width * 0.05),
              //comments
              Image.asset('assets/icons/comments.png'),
              SizedBox(width: 6.0),
              //send count
              Text('${activity['comments_count']} Comments'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _testActivity(dynamic activity) {
    return Container(
      height: screenSize.height * 0.24,
      margin: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 22.0,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 22.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6.0,
          )
        ],
      ),
      child: Column(
        children: [
          _activityTitle(
            activity['title'],
            Color(0xFFC04DD8),
            activity['followers'],
            activity['created_at'],
          ),
          //center
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 22.0,
                horizontal: 32.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //description
                  SizedBox(
                    width: screenSize.width * 0.2,
                    child: Text(activity['description']),
                  ),
                  //test status
                  activity['doe'] == null
                      ? Container()
                      : DateTime.parse(activity['doe']).isBefore(DateTime.now())
                          ? _displayPieChart(activity['results'])
                          : Container()
                ],
              ),
            ),
          ),
          //footer
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //sendTo
              Image.asset('assets/icons/sendTo.png'),
              SizedBox(width: 6.0),
              //send count
              Text('${activity['sent_to']} Send To'),
              //spacing
              SizedBox(width: screenSize.width * 0.05),
              //attempted
              Image.asset('assets/icons/attempted.png'),
              SizedBox(width: 6.0),
              //send count
              Text('Attempted'),
              //spacing
              SizedBox(width: screenSize.width * 0.05),
              //not attempted
              Image.asset('assets/icons/not_attempted.png'),
              SizedBox(width: 6.0),
              //send count
              Text('Not Attempted'),
              //spacing
              SizedBox(width: screenSize.width * 0.05),
              //forward
              Image.asset('assets/icons/forward.png'),
              SizedBox(width: 6.0),
              //send count
              Text('Forward To')
            ],
          ),
        ],
      ),
    );
  }

  Widget _feedbackActivity(dynamic activity) {
    TextEditingController controller = TextEditingController();
    return Container(
      height: screenSize.height * 0.2,
      margin: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 22.0,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 22.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6.0,
          )
        ],
      ),
      child: Column(
        children: [
          //yahan indices ka error aarha hai
          _activityTitle(
            activity['title'],
            Color(0xFF4FB277),
            activity['followers'],
            activity['start_time'],
          ),
          //center
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 22.0,
                horizontal: 32.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //description
                  SizedBox(
                    width: screenSize.width * 0.2,
                    child: Text(activity['description']),
                  ),
                ],
              ),
            ),
          ),
          //footer
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //sendTo
              Image.asset('assets/icons/sendTo.png'),
              SizedBox(width: 6.0),
              //send count
              Text('${activity['sent_to']} Send To'),
              //spacing
              SizedBox(width: screenSize.width * 0.05),
              //comments
              Image.asset('assets/icons/comments.png'),
              SizedBox(width: 6.0),
              //send count
              Text('${activity['comments_count']} Comments')
            ],
          ),
          Container(
            height: screenSize.height * 0.07,
            padding: const EdgeInsets.only(left: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Color(0xFFf5f6fa),
            ),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Enter your comment',
                      hintStyle:
                          textTheme.headline6.copyWith(color: Colors.grey[400]),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(width: 12.0),
                SizedBox(
                  width: 64.0,
                  child: FlatButton(
                    onPressed: () {
                      context
                          .bloc<CommentCubit>()
                          .postSurveyComment(activity['id'], controller.text);
                    },
                    child: Icon(
                      Icons.send,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          BlocBuilder(
            cubit: context.bloc<CommentCubit>()
              ..getSurveyComments(activity['id']),
            // ignore: missing_return
            builder: (BuildContext context, state) {
              if (state is MaterialCommentsFetched) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.materialComment.data.length,
                  itemBuilder: (ctx, index) => Align(
                    alignment:
                        state.materialComment.data[index].college_account_id ==
                                null
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                    child: Container(
                      height: screenSize.height * 0.07,
                      width: screenSize.width * 0.3,
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: state.materialComment.data[index]
                                    .college_account_id ==
                                null
                            ? Color(0xFF7bed9f).withOpacity(0.5)
                            : Color(0xFFff6b81).withOpacity(0.5),
                      ),
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(32.0),
                                    child: Image.network(
                                      state.materialComment.data[index]
                                                  .college_account_id ==
                                              null
                                          ? state.materialComment.data[index]
                                              .student.profile_pic
                                          : state.materialComment.data[index]
                                              .college_account.profile_pic,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              SizedBox(
                                width: screenSize.width * 0.25,
                                child: Text(
                                  state.materialComment.data[index].comment,
                                  maxLines: 2,
                                  softWrap: true,
                                  style: textTheme.headline5,
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            right: 4.0,
                            bottom: 4.0,
                            child: Text(state
                                .materialComment.data[index].created_at
                                .toString()),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              if (state is MaterialCommentFailed) {
                return Text(' ');
              }
              if (state is MaterialCommentInitial) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Widget _notificationActivity(dynamic activity) {
    TextEditingController controller = TextEditingController();
    return Container(
      height: screenSize.height * 0.3,
      margin: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 22.0,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 22.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6.0,
          )
        ],
      ),
      child: Column(
        children: [
          _activityTitle(
            activity['title'],
            Color(0xFF508AE0),
            activity['followers'],
            activity['created_at'],
          ),
          //center
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 22.0,
                horizontal: 32.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //description
                  Text(
                    activity['description'],
                  ),
                  //notification thumbnail
                  activity['thumb_url'] == null
                      ? SizedBox.shrink()
                      : GestureDetector(
                          onTap: () =>
                              html.window.open(activity['file_url'], 'URL'),
                          child: Image.network(activity['thumb_url'])),
                ],
              ),
            ),
          ),
          //footer
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //sendTo
              Image.asset('assets/icons/sendTo.png'),
              SizedBox(width: 6.0),
              //send count
              Text('${activity['sent_to']} Send To'),
              //spacing
              SizedBox(width: screenSize.width * 0.05),
              //comments
              Image.asset('assets/icons/comments.png'),
              SizedBox(width: 6.0),
              //send count
              Text('${activity['comments_counts']} Comments')
            ],
          ),
          Container(
            height: screenSize.height * 0.07,
            padding: const EdgeInsets.only(left: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Color(0xFFf5f6fa),
            ),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Enter your comment',
                      hintStyle:
                          textTheme.headline6.copyWith(color: Colors.grey[400]),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(width: 12.0),
                SizedBox(
                  width: 64.0,
                  child: FlatButton(
                    onPressed: () {
                      context.bloc<CommentCubit>().postNotificationComment(
                          activity['id'], controller.text);
                    },
                    child: Icon(
                      Icons.send,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          BlocBuilder(
            cubit: context.bloc<CommentCubit>()
              ..getNotificationComments(activity['id']),
            // ignore: missing_return
            builder: (BuildContext context, state) {
              if (state is MaterialCommentsFetched) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.materialComment.data.length,
                  itemBuilder: (ctx, index) => Align(
                    alignment:
                        state.materialComment.data[index].college_account_id ==
                                null
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                    child: Container(
                      height: screenSize.height * 0.07,
                      width: screenSize.width * 0.3,
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: state.materialComment.data[index]
                                    .college_account_id ==
                                null
                            ? Color(0xFF7bed9f).withOpacity(0.5)
                            : Color(0xFFff6b81).withOpacity(0.5),
                      ),
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(32.0),
                                    child: Image.network(
                                      state.materialComment.data[index]
                                                  .college_account_id ==
                                              null
                                          ? state.materialComment.data[index]
                                              .student.profile_pic
                                          : state.materialComment.data[index]
                                              .college_account.profile_pic,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              SizedBox(
                                width: screenSize.width * 0.25,
                                child: Text(
                                  state.materialComment.data[index].comment,
                                  maxLines: 2,
                                  softWrap: true,
                                  style: textTheme.headline5,
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            right: 4.0,
                            bottom: 4.0,
                            child: Text(state
                                .materialComment.data[index].created_at
                                .toString()),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              if (state is MaterialCommentFailed) {
                return Text(' ');
              }
              if (state is MaterialCommentInitial) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Widget _activityTitle(
    String title,
    Color color,
    dynamic followers,
    String time,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //initials
        CircleAvatar(
          radius: 25.0,
          backgroundColor: color,
          child: Text(
            title.substring(0, 1).toUpperCase(),
            style: textTheme.headline3,
          ),
        ),
        //spacing
        SizedBox(width: 8.0),
        //left part
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //title
            Text(
              title,
              style: textTheme.headline5,
            ),
            //time
            Text(
              time.toString(),
              style: textTheme.bodyText1,
            ),
          ],
        ),
        //spacing
        Spacer(),
        //right part
        Text('Follower'),
        //spacing
        SizedBox(
          width: 12.0,
        ),
        // followers
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CircleAvatar(
                radius: 25.0,
                backgroundColor: color,
                child: followers.toString() == '[]'
                    ? Container()
                    : Text(
                        followers[0]['faculty_name']
                            .substring(0, 1)
                            .toUpperCase(),
                        style: textTheme.headline3,
                      ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _yourCoursesList(dynamic courses) {
    ScrollController scrollController = ScrollController();
    return SizedBox(
      height: screenSize.height * 0.19,
      width: screenSize.width * 0.59,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              scrollDirection: Axis.horizontal,
              itemCount: courses.length,
              itemBuilder: (ctx, index) => _courseCard(courses[index]),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 48.0,
              width: 48.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32.0),
              ),
              padding: const EdgeInsets.only(left: 8.0),
              alignment: Alignment.center,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                /* no-op */
                onPressed: () => scrollController.animateTo(
                  scrollController.offset - screenSize.width * 0.12,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 48.0,
              width: 48.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32.0),
              ),
              padding: const EdgeInsets.only(left: 8.0),
              alignment: Alignment.center,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
                /* no-op */
                onPressed: () => scrollController.animateTo(
                  scrollController.offset + screenSize.width * 0.12,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _courseCard(dynamic course) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => CourseDetailScreen(
            course['name'],
            course['subject_semester_id'],
            course['id'],
          ),
        ),
      ),
      child: Container(
        height: screenSize.height * 0.18,
        width: screenSize.width * 0.12,
        margin: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 8.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          image: DecorationImage(
            image: course['course_image'].toString().isEmpty
                ? AssetImage('placeholder_image.jpg')
                : NetworkImage(
                    course['course_image'],
                  ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SizedBox(
                height: screenSize.height * 0.04,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Theme.of(context).primaryColor.withOpacity(0.8),
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    width: 180,
                    child: Text(
                      course['name'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _displayPieChart(dynamic results) {
    if (results['percentage_very_good'] +
            results['percentage_below_average'] +
            results['percentage_average'] +
            results['percentage_good'] +
            results['understanding_level'] ==
        100) {
      return Container(
        width: 50,
        height: 50,
        child: PieChart(
          PieChartData(
            startDegreeOffset: 180,
            centerSpaceRadius: 10,
            sections: [
              PieChartSectionData(
                value: double.parse(results['percentage_very_good'].toString()),
                radius: 15,
                title: 'Very Good',
              ),
              PieChartSectionData(
                value: double.parse(
                    results['percentage_below_average'].toString()),
                radius: 15,
                title: 'Below Average',
              ),
              PieChartSectionData(
                value: double.parse(results['percentage_average'].toString()),
                radius: 15,
                title: 'Average',
              ),
              PieChartSectionData(
                value: double.parse(results['percentage_good'].toString()),
                radius: 15,
                title: 'Good',
              ),
              PieChartSectionData(
                value: double.parse(results['understanding_level'].toString()),
                radius: 15,
                title: 'Understanding Level',
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
