import 'package:edwisely/widgets/listitem.dart';
import 'package:edwisely/widgets/redchip.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            height: double.infinity,
            width: 130,
            color: Theme.of(context).primaryColor,
          ),
          Column(
            children: [
              RedChip(label: 'Knowledge'),
              ListItem(label: 'Lorem ipsum dolor sit amet'),
            ],
          ),
        ],
      ),
    );
  }
}
