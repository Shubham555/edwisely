import 'package:flutter/material.dart';

class SideDrawerItem extends StatelessWidget {
  final bool isCollapsed;
  final String title;
  final IconData icon;
  final int myIndex;
  final int currentIndex;

  SideDrawerItem({
    @required this.isCollapsed,
    @required this.title,
    @required this.icon,
    @required this.myIndex,
    @required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = currentIndex == myIndex;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 18.0,
        horizontal: 18.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.white : Colors.grey,
          ),
          isCollapsed
              ? SizedBox.shrink()
              : SizedBox(
                  width: 22.0,
                ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
            width: isCollapsed ? 0 : null,
            child: isCollapsed
                ? SizedBox.shrink()
                : Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
