import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './side_drawer_item.dart';

class NavigationDrawer extends StatefulWidget {
  final isCollapsed;
  final PageController pageController;

  NavigationDrawer({this.isCollapsed = true, this.pageController});

  @override
  _NavigationDrawerState createState() =>
      _NavigationDrawerState(pageController);
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  bool _isNavigationDrawerCollapsed = false;
  PageController pageController;
  double _sidebarWidth;

  Size screenSize;
  TextTheme textTheme;

  _NavigationDrawerState(this.pageController);

  @override
  void initState() {
    super.initState();

    _isNavigationDrawerCollapsed = widget.isCollapsed;
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    textTheme = Theme.of(context).textTheme;

    if (screenSize.width < 1000) {
      _sidebarWidth = _isNavigationDrawerCollapsed
          ? screenSize.width * 0.08
          : screenSize.width * 0.28;
    } else {
      _sidebarWidth = _isNavigationDrawerCollapsed
          ? screenSize.width * 0.05
          : screenSize.width * 0.15;
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOutBack,
      width: _sidebarWidth,
      height: screenSize.height,
      padding: const EdgeInsets.symmetric(
        vertical: 18.0,
        horizontal: 18.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //logo here
          Image.asset(
            _isNavigationDrawerCollapsed
                ? 'assets/logo/small_logo.png'
                : 'assets/logo/big_logo.png',
            fit: BoxFit.contain,
          ),
          //seperator
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Divider(),
          ),
          //list of options
          SideDrawerItem(
              isCollapsed: _isNavigationDrawerCollapsed,
              title: 'All Courses',
              icon: Icons.import_contacts,
              function: () => pageController.animateToPage(0,
                  duration: Duration(milliseconds: 250), curve: Curves.ease)),
          SideDrawerItem(
            isCollapsed: _isNavigationDrawerCollapsed,
            title: 'Add Course',
            icon: Icons.book,
            function: () => pageController.animateToPage(1,
                duration: Duration(milliseconds: 250), curve: Curves.ease),
          ),
          SideDrawerItem(
            isCollapsed: _isNavigationDrawerCollapsed,
            title: 'Assesments',
            icon: Icons.assessment,
            function: () => pageController.animateToPage(2,
                duration: Duration(milliseconds: 250), curve: Curves.ease),
          ),
          SideDrawerItem(
            isCollapsed: _isNavigationDrawerCollapsed,
            title: 'Live Class',
            icon: Icons.live_tv,
          ),
          SideDrawerItem(
            isCollapsed: _isNavigationDrawerCollapsed,
            title: 'Send Assignment',
            icon: Icons.assignment,
            function: () => pageController.animateToPage(2,
                duration: Duration(milliseconds: 250), curve: Curves.ease),
          ),
          SideDrawerItem(
            isCollapsed: _isNavigationDrawerCollapsed,
            title: 'Schedule Event',
            icon: Icons.calendar_today,
          ),
          SideDrawerItem(
            isCollapsed: _isNavigationDrawerCollapsed,
            title: 'My Assesment',
            icon: Icons.assignment_ind,
            function: () => pageController.animateToPage(2,
                duration: Duration(milliseconds: 250), curve: Curves.ease),
          ),
          SideDrawerItem(
            isCollapsed: _isNavigationDrawerCollapsed,
            title: 'Upcoming Events',
            icon: Icons.event,
          ),
          SideDrawerItem(
            isCollapsed: _isNavigationDrawerCollapsed,
            title: 'Get Feedback',
            icon: Icons.feedback,
          ),
          SideDrawerItem(
            isCollapsed: _isNavigationDrawerCollapsed,
            title: 'Recently Viewed',
            icon: Icons.schedule,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: InkWell(
              onTap: () => setState(() =>
                  _isNavigationDrawerCollapsed = !_isNavigationDrawerCollapsed),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                    width: _isNavigationDrawerCollapsed ? 0 : null,
                    child: _isNavigationDrawerCollapsed
                        ? SizedBox.shrink()
                        : Text(
                            _isNavigationDrawerCollapsed
                                ? 'Expand'
                                : 'Collapse',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                  ),
                  _isNavigationDrawerCollapsed
                      ? SizedBox.shrink()
                      : SizedBox(
                          width: 8.0,
                        ),
                  Icon(
                    _isNavigationDrawerCollapsed
                        ? Icons.arrow_forward_ios
                        : Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
