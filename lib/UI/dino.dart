import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Mydino extends StatelessWidget {
  int running = 0;
  Mydino(int running) {
    this.running = running;
  }

  @override
  Widget build(BuildContext context) {
    switch (running) {
      case 0:
        return Container(
          width: 90,
          height: 90,
          child: Image.asset('assets/dino/Idle (1).png'),
        );
      case 1:
        return Container(
          width: 90,
          height: 90,
          child: Image.asset('assets/dino/Run (1).png'),
        );
      case 2:
        return Container(
          width: 90,
          height: 90,
          child: Image.asset('assets/dino/Run (2).png'),
        );
      case 3:
        return Container(
          width: 90,
          height: 90,
          child: Image.asset('assets/dino/Run (3).png'),
        );
      case 4:
        return Container(
          width: 90,
          height: 90,
          child: Image.asset('assets/dino/Run (4).png'),
        );
      case 5:
        return Container(
          width: 90,
          height: 90,
          child: Image.asset('assets/dino/Run (5).png'),
        );
      case 6:
        return Container(
          width: 90,
          height: 90,
          child: Image.asset('assets/dino/Run (6).png'),
        );
      case 7:
        return Container(
          width: 90,
          height: 90,
          child: Image.asset('assets/dino/Run (7).png'),
        );
      case 8:
        return Container(
          width: 90,
          height: 90,
          child: Image.asset('assets/dino/Run (8).png'),
        );
    }
    return Container();
  }
}
