// Widget for a reading snippet
// TODO: Modify to adhere to new design

import 'package:flutter/material.dart';

class SnippetTile extends StatelessWidget {
  final String title;
  final String subject;
  final String level;
  final String source;
  final String readingTime;
  final Function report;

  SnippetTile({
    @required this.title,
    @required this.subject,
    @required this.level,
    @required this.readingTime,
    @required this.source,
    @required this.report,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 742,
      height: 100,
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 22,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 9),
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  color: Color.fromRGBO(196, 196, 196, 1),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    'Sub title',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(116, 116, 116, 1),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Level: ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(116, 116, 116, 1),
                    ),
                  ),
                  Text(
                    level,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Source: ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(116, 116, 116, 1),
                    ),
                  ),
                  Text(
                    source,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Reading Time: ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(116, 116, 116, 1),
                    ),
                  ),
                  Text(
                    readingTime,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Bookmark: ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(116, 116, 116, 1),
                    ),
                  ),
                  Icon(
                    Icons.bookmark_border,
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                onPressed: report,
                child: Text(
                  'Report',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
