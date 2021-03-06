import 'package:flutter/material.dart';

class SideDrawerItem extends StatelessWidget {
  final bool isCollapsed;
  final String title;
  final IconData icon;
  final int myIndex;
  final int currentIndex;
  final Color selectedColor;

  SideDrawerItem({
    @required this.isCollapsed,
    @required this.title,
    @required this.icon,
    @required this.myIndex,
    @required this.currentIndex,
    this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = currentIndex == myIndex;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.02,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment:
            isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: isSelected
                ? selectedColor != null
                    ? selectedColor
                    : Colors.white
                : Colors.grey,
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
                : FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      title,
                      // maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 19.5,
                        color: isSelected
                            ? selectedColor != null
                                ? selectedColor
                                : Colors.white
                            : Colors.grey,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
