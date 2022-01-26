import 'package:flutter/material.dart';

LinearGradient topGradient() {
  return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.white, Colors.amber[700]!]);
}
