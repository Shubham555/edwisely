import 'package:flutter/material.dart';

import '../widgets_util/navigation_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Size screenSize;
  TextTheme textTheme;

  final List<MyCourse> _yourCourses = [
    MyCourse(
      title: 'Web Technology',
      image: 'assets/placeholder_image.jpg',
    ),
    MyCourse(
      title: 'DBMS',
      image: 'assets/placeholder_image.jpg',
    ),
    MyCourse(
      title: 'Chemistry',
      image: 'assets/placeholder_image.jpg',
    ),
    MyCourse(
      title: 'Physics',
      image: 'assets/placeholder_image.jpg',
    ),
    MyCourse(
      title: 'Mathematics II',
      image: 'assets/placeholder_image.jpg',
    ),
    MyCourse(
      title: 'OOPM',
      image: 'assets/placeholder_image.jpg',
    ),
  ];
  final List<ActivityWall> _activityWall = [
    ActivityWall(
      title: 'Activity Title',
      type: NotificationType.MEETING,
      time: DateTime.now(),
      followers: [
        'assets/placeholder_image.jpg',
        'assets/placeholder_image.jpg'
      ],
      meetingName: 'Meeting Name',
      meetingStartTime: DateTime.now(),
      meetingEndTime: DateTime.now(),
      status: 'Meeting Completed',
      sendTo: 10,
      commentsCount: 0,
    ),
    ActivityWall(
      title: 'Test Title',
      type: NotificationType.TEST,
      time: DateTime.now(),
      followers: [
        'assets/placeholder_image.jpg',
        'assets/placeholder_image.jpg'
      ],
      description:
          'A questionnaire named Test created and set to be expired on 25 Sep 2020 02:15 PM',
      status: 'Test in progress',
      sendTo: 10,
      attemptedCount: 0,
      notAttemptedCount: 10,
    ),
    ActivityWall(
      title: 'Test Title',
      type: NotificationType.FEEDBACK,
      time: DateTime.now(),
      followers: [
        'assets/placeholder_image.jpg',
        'assets/placeholder_image.jpg'
      ],
      description:
          'We wish you a Merry Christmas and a Happy New Year. See you all on 2nd Jan. Peace!',
      sendTo: 10,
      commentsCount: 2,
    ),
  ];
  final List<UpcomingEvent> _upcomingEvents = [
    UpcomingEvent(
      title: 'Test 1 results are out',
      type: UpcomingEventType.RESULT,
    ),
    UpcomingEvent(
      title: 'Test - Assesment 1 is going to start at 5:00PM today.',
      type: UpcomingEventType.ANNOUNCEMENT,
    ),
    UpcomingEvent(
      title: 'Test 1 results are out',
      type: UpcomingEventType.RESULT,
    ),
    UpcomingEvent(
      title: 'Test - Assesment 1 is going to start at 5:00PM today.',
      type: UpcomingEventType.ANNOUNCEMENT,
    ),
  ];
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //heading text
                        Text(
                          'Your Courses',
                          style: textTheme.headline2,
                        ),
                        //list of courses
                        _yourCoursesList(),
                        //spacing
                        SizedBox(height: 18.0),
                        //heading text
                        Text(
                          'Activity Wall',
                          style: textTheme.headline2,
                        ),
                        //activityWall
                        _activityWallList(),
                      ],
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
        itemCount: _upcomingEvents.length,
        itemBuilder: (ctx, index) => _upcomingEventCard(_upcomingEvents[index]),
      ),
    );
  }

  Widget _upcomingEventCard(UpcomingEvent event) {
    return ListTile(
      leading: Image.asset('assets/icons/announcement.png'),
      title: Text(event.title),
      trailing: event.type == UpcomingEventType.RESULT
          ? Text('View')
          : SizedBox.shrink(),
    );
  }

  Widget _activityWallList() {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _activityWall.length,
        itemBuilder: (ctx, index) {
          switch (_activityWall[index].type) {
            case NotificationType.TEST:
              return _testActivity(_activityWall[index]);
              break;
            case NotificationType.NOTIFICATION:
              return _notificationActivity(_activityWall[index]);
              break;
            case NotificationType.FEEDBACK:
              return _feedbackActivity(_activityWall[index]);
              break;
            case NotificationType.MEETING:
              return _meetingActivity(_activityWall[index]);
              break;
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget _meetingActivity(ActivityWall activity) {
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
            activity.title,
            Color(0xFF4ED8DA),
            activity.followers,
            activity.time,
          ),
          //center portion
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 22.0, horizontal: 32.0),
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
                        activity.meetingName,
                        style: textTheme.headline5,
                      ),
                      //start time
                      Text.rich(
                        TextSpan(
                          text: 'Start Time:    ',
                          style: textTheme.headline6,
                          children: [
                            TextSpan(
                              text: activity.meetingStartTime.toString(),
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
                              text: activity.meetingEndTime.toString(),
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
                  Text(
                    activity.status,
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
              Text('${activity.sendTo} Send To'),
              //spacing
              SizedBox(width: screenSize.width * 0.05),
              //comments
              Image.asset('assets/icons/comments.png'),
              SizedBox(width: 6.0),
              //send count
              Text('${activity.commentsCount} Comments')
            ],
          ),
        ],
      ),
    );
  }

  Widget _testActivity(ActivityWall activity) {
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
            activity.title,
            Color(0xFFC04DD8),
            activity.followers,
            activity.time,
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
                    child: Text(activity.description),
                  ),
                  //test status
                  Text(
                    activity.status,
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
              Text('${activity.sendTo} Send To'),
              //spacing
              SizedBox(width: screenSize.width * 0.05),
              //attempted
              Image.asset('assets/icons/attempted.png'),
              SizedBox(width: 6.0),
              //send count
              Text('${activity.attemptedCount} Attempted'),
              //spacing
              SizedBox(width: screenSize.width * 0.05),
              //not attempted
              Image.asset('assets/icons/not_attempted.png'),
              SizedBox(width: 6.0),
              //send count
              Text('${activity.notAttemptedCount} Not Attempted'),
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

  Widget _feedbackActivity(ActivityWall activity) {
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
            activity.title,
            Color(0xFF4FB277),
            activity.followers,
            activity.time,
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
                    child: Text(activity.description),
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
              Text('${activity.sendTo} Send To'),
              //spacing
              SizedBox(width: screenSize.width * 0.05),
              //comments
              Image.asset('assets/icons/comments.png'),
              SizedBox(width: 6.0),
              //send count
              Text('${activity.commentsCount} Comments')
            ],
          ),
        ],
      ),
    );
  }

  Widget _notificationActivity(ActivityWall activity) {
    return SizedBox.shrink();
  }

  Widget _activityTitle(
    String title,
    Color color,
    List<String> followers,
    DateTime time,
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
        Text('Followers'),
        //spacing
        SizedBox(
          width: 12.0,
        ),
        //followers
        Row(
          children: followers
              .sublist(0, 2)
              .map(
                (follower) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CircleAvatar(
                    radius: 25.0,
                    backgroundImage: AssetImage(follower),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _yourCoursesList() {
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
              itemCount: _yourCourses.length,
              itemBuilder: (ctx, index) => _courseCard(_yourCourses[index]),
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

  Widget _courseCard(MyCourse course) {
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
          image: AssetImage(course.image),
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
                  course.title,
                  style: textTheme.headline3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyCourse {
  final String title;
  final String image;

  MyCourse({
    @required this.title,
    @required this.image,
  });
}

class ActivityWall {
  final String title;
  final DateTime time;
  final int sendTo;
  final int commentsCount;
  final int attemptedCount;
  final int notAttemptedCount;
  final List<String> followers;
  final String status;
  final NotificationType type;
  final String meetingName;
  final DateTime meetingStartTime;
  final DateTime meetingEndTime;
  final String description;

  ActivityWall({
    this.title,
    this.time,
    this.sendTo,
    this.commentsCount,
    this.attemptedCount,
    this.notAttemptedCount,
    this.followers,
    this.status,
    this.type,
    this.meetingName,
    this.meetingStartTime,
    this.meetingEndTime,
    this.description,
  });
}

enum NotificationType { TEST, FEEDBACK, NOTIFICATION, MEETING }

class UpcomingEvent {
  final String title;
  final UpcomingEventType type;

  UpcomingEvent({
    @required this.title,
    @required this.type,
  });
}

enum UpcomingEventType { RESULT, ANNOUNCEMENT }
