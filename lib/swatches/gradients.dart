import 'package:flutter/material.dart';

class Gradients {
  static final LinearGradient peacock = LinearGradient(colors: [
    Colors.purple,
    Colors.blue,
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
