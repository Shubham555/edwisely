import 'package:flutter/material.dart';

class ChoiceTile extends StatelessWidget {
  int index;
  Function answerRefresher;
  ChoiceTile({this.index, this.answerRefresher});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            offset: Offset.zero,
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      width: 1.8 * MediaQuery.of(context).size.width / 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: TextField(
                onChanged: (text) {
                  // widget.questionRefresher(text);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Your answer here',
                  hintStyle: TextStyle(
                    fontSize: 18,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.check_box),
            onPressed: () {},
            highlightColor: Theme.of(context).primaryColor,
            focusColor: Theme.of(context).primaryColor,
            // hoverColor: ,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
