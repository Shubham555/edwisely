import 'package:edwisely/data/cubits/home_screen_default_cubit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets_util/navigation_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Size screenSize;
  TextTheme textTheme;
  HomeScreenDefaultCubit homeScreenDefaultCubit;
  final List<String> _peerActivity = [
    'Dr. Geetha has created a test for CSE 2 Section A.',
    'Prof. Namratha has sent a notification to CSE 2 Section A, 2 Section B.',
    'Dr. Geetha has created a test for CSE 2 Section A.',
    'Prof. Namratha has sent a notification to CSE 2 Section A, 2 Section B.',
    'Dr. Geetha has created a test for CSE 2 Section A.',
    'Prof. Namratha has sent a notification to CSE 2 Section A, 2 Section B.',
  ];

  @override
  Widget build(BuildContext context) {
    homeScreenDefaultCubit = context.bloc<HomeScreenDefaultCubit>()..getHomeScreenContent();
    screenSize = MediaQuery.of(context).size;
    textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //side bar
          NavigationDrawer(
            isCollapsed: false,
            isHome: true,
          ),
          //rest of the screen
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //center part
                SizedBox(
                  width: screenSize.width * 0.6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 22.0,
                      horizontal: 36.0,
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
                SizedBox(
                  width: screenSize.width * 0.22,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: screenSize.width * 0.22,
                        height: screenSize.height * 0.28,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 28.0,
                            horizontal: 22.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'send an assesment',
                                style: textTheme.headline6,
                              ),
                              Text(
                                'send a notification',
                                style: textTheme.headline6,
                              ),
                              Text(
                                'send documents',
                                style: textTheme.headline6,
                              ),
                              Text(
                                'add material',
                                style: textTheme.headline6,
                              ),
                              Text(
                                'create a live meeting',
                                style: textTheme.headline6,
                              ),
                            ],
                          ),
                        ),
                      ),
                      //spacing
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      //heading text
                      Text(
                        'Upcoming',
                        style: textTheme.headline2,
                      ),
                      _upcomingEventsList(),
                      //spacing
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      //heading text
                      Text(
                        'Peer Activity',
                        style: textTheme.headline2,
                      ),
                      _peerActivityList(),
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

  Widget _peerActivityList() {
    return Container(
      height: screenSize.height * 0.25,
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
        border: Border.all(
          color: Colors.black,
          width: 0.5,
        ),
      ),
      child: ListView.builder(
        itemCount: _peerActivity.length,
        itemBuilder: (ctx, index) => _peerActivityCard(_peerActivity[index]),
      ),
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
          return Container(
            height: screenSize.height * 0.25,
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
              border: Border.all(
                color: Colors.black,
                width: 0.5,
              ),
            ),
            child: Column(
              children: [
                Text('Objective'),
                Text('Subjective'),
                Text('VC'),
                // TODO: 10/4/2020 get some data to make class
                // ListView.builder(
                //   itemCount: state.homeScreenDefault.upcoming_events.objective_tests.length,
                //   itemBuilder: (BuildContext context, int index) => ListTile(
                //     title: state.homeScreenDefault.upcoming_events.objective_tests[index],
                //   ),
                // )
              ],
            ),
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
        scrollDirection: Axis.vertical,
        itemCount: activityTab.length,
        itemBuilder: (ctx, index) {
          switch (activityTab[index]['type']) {
            case 'Test':
              return _testActivity(activityTab[index]);
              break;
            case 'Notification':
              return _notificationActivity(activityTab[index]);
              break;
            case 'Feedback':
              return _feedbackActivity(activityTab[index]);
              break;
            case 'VideoConference':
              return _meetingActivity(activityTab[index]);
              break;
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget _meetingActivity(dynamic activity) {
    return Container(
      height: screenSize.height * 0.27,
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 32.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    ],
                  ),
                  //right part
                  activity['doe'] == null
                      ? Text('sdv')
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
              //comments
              Image.asset('assets/icons/comments.png'),
              SizedBox(width: 6.0),
              //send count
              Text('${activity['comments_count']} Comments')
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
                  //test status
                  Text(
                    // FIXME: 10/4/2020 status
                    '',
                    style: textTheme.headline2,
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
        ],
      ),
    );
  }

  Widget _notificationActivity(dynamic activity) {
    return SizedBox.shrink();
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
                child: Text(
                  followers[0]['faculty_name'].substring(0, 1).toUpperCase(),
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
                onPressed: () {},
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
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _courseCard(dynamic course) {
    return Container(
      height: screenSize.height * 0.18,
      width: screenSize.width * 0.12,
      margin: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 8.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
          image: NetworkImage(course['course_image']),
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
                child: Text(
                  course['name'],
                  style: textTheme.headline3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _displayPieChart(dynamic results) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: results['percentage_very_good'],
            radius: 15,
            title: 'Very Good',
          ),
          PieChartSectionData(
            value: results['percentage_below_average'],
            radius: 15,
            title: 'Below Average',
          ),
          PieChartSectionData(
            value: results['percentage_average'],
            radius: 15,
            title: 'Average',
          ),
          PieChartSectionData(
            value: results['percentage_good'],
            radius: 15,
            title: 'Good',
          ),
          PieChartSectionData(
            value: results['understanding_level'],
            radius: 15,
            title: 'Understanding Level',
          ),
        ],
      ),
    );
  }
}
