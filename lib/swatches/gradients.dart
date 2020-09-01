import 'package:flutter/material.dart';

//Some gradients to be used for various widgets across the app
// The peacock gradient is the one currently used on all widgets

class Gradients {
  static final LinearGradient peacock = LinearGradient(colors: [
    Color(0xFF1D2B64),
    Color(0xFFF8CDDA),
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
