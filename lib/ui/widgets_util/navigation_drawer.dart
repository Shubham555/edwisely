import 'package:flutter/material.dart';

import './side_drawer_item.dart';

class NavigationDrawer extends StatefulWidget {
  final isCollapsed;
  final selectedIndex;
  final Function onPageChanged;

  NavigationDrawer({
    this.isCollapsed = true,
    this.selectedIndex,
    @required this.onPageChanged,
  });

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  bool _isNavigationDrawerCollapsed = false;

  double _sidebarWidth;

  Size screenSize;
  TextTheme textTheme;

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
          ? screenSize.width * 0.1
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
          InkWell(
            onTap: () => widget.onPageChanged(0),
            child: SideDrawerItem(
              isCollapsed: _isNavigationDrawerCollapsed,
              title: 'All Courses',
              icon: Icons.import_contacts,
              myIndex: 0,
              currentIndex: widget.selectedIndex,
            ),
          ),
          InkWell(
            onTap: () => widget.onPageChanged(1),
            child: SideDrawerItem(
              isCollapsed: _isNavigationDrawerCollapsed,
              title: 'Add Course',
              icon: Icons.book,
              myIndex: 1,
              currentIndex: widget.selectedIndex,
            ),
          ),
          InkWell(
            onTap: () => widget.onPageChanged(2),
            child: SideDrawerItem(
              isCollapsed: _isNavigationDrawerCollapsed,
              title: 'Assesments',
              icon: Icons.assessment,
              myIndex: 2,
              currentIndex: widget.selectedIndex,
            ),
          ),
          SideDrawerItem(
            isCollapsed: _isNavigationDrawerCollapsed,
            title: 'Live Class',
            icon: Icons.live_tv,
            myIndex: 3,
            currentIndex: widget.selectedIndex,
          ),
          SideDrawerItem(
            isCollapsed: _isNavigationDrawerCollapsed,
            title: 'Send Assignment',
            icon: Icons.assignment,
            myIndex: 4,
            currentIndex: widget.selectedIndex,
          ),
          // SideDrawerItem(
          //   isCollapsed: _isNavigationDrawerCollapsed,
          //   title: 'Schedule Event',
          //   icon: Icons.calendar_today,
          //   myIndex: 5,
          //   currentIndex: widget.selectedIndex,
          // ),
          // SideDrawerItem(
          //   isCollapsed: _isNavigationDrawerCollapsed,
          //   title: 'My Assesment',
          //   icon: Icons.assignment_ind,
          //   myIndex: 6,
          //   currentIndex: widget.selectedIndex,
          // ),
          // SideDrawerItem(
          //   isCollapsed: _isNavigationDrawerCollapsed,
          //   title: 'Upcoming Events',
          //   icon: Icons.event,
          //   myIndex: 7,
          //   currentIndex: widget.selectedIndex,
          // ),
          // SideDrawerItem(
          //   isCollapsed: _isNavigationDrawerCollapsed,
          //   title: 'Get Feedback',
          //   icon: Icons.feedback,
          //   myIndex: 8,
          //   currentIndex: widget.selectedIndex,
          // ),
          // SideDrawerItem(
          //   isCollapsed: _isNavigationDrawerCollapsed,
          //   title: 'Recently Viewed',
          //   icon: Icons.schedule,
          //   myIndex: 9,
          //   currentIndex: widget.selectedIndex,
          // ),
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
