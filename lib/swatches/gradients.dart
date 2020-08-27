import 'package:flutter/material.dart';

class Gradients {
  static final LinearGradient peacock = LinearGradient(colors: [
    Color.fromRGBO(29, 43, 100, 1),
    Color.fromRGBO(117, 29, 56, 1),
  ], begin: Alignment.topLeft, end: Alignment.bottomRight);

  static final LinearGradient kingfisher = LinearGradient(colors: [
    Colors.blueAccent,
    Colors.blue,
  ], begin: Alignment.topLeft, end: Alignment.bottomRight);

  static final LinearGradient macaw = LinearGradient(colors: [
    Colors.deepOrange,
    Colors.red,
  ], begin: Alignment.topLeft, end: Alignment.bottomRight);
}
