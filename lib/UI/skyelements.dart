import 'package:flutter/material.dart';

Widget cloud() {
  return Container(
    alignment: Alignment.topRight,
    child: Image.asset(
      'assets/sky/Cloud.png',
      height: 100,
      width: 100,
    ),
  );
}

Widget sun() {
  return Container(
    alignment: Alignment.topLeft,
    child: Image.asset(
      'assets/sky/Sun.png',
      height: 120,
      width: 120,
    ),
  );
}
