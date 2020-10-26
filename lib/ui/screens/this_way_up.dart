import 'package:flutter/material.dart';

bool oneWay(BuildContext context) {
  final _screenSize = MediaQuery.of(context).size;
  if (_screenSize.height > _screenSize.width)
    return true;
  else
    return false;
}

class ThisWayUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFF2A2A2A),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.screen_rotation,
                  color: Colors.white,
                ),
              ),
              Text(
                "Use in Fullscreen Landscape to resume",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
