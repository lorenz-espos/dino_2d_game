import 'package:flutter/material.dart';
import 'dart:math';

class Mydino extends StatelessWidget {
  String direction = "right";
  bool running = false;
  Mydino(String direction, bool running) {
    this.direction = direction;
    this.running = running;
  }

  @override
  Widget build(BuildContext context) {
    if (direction == "right") {
      return Container(
        width: 85,
        height: 85,
        child: running
            ? Image.asset('assets/dino/Idle (1).png')
            : Image.asset('assets/dino/Run (7).png'),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
            width: 85,
            height: 85,
            child: running
                ? Image.asset('assets/dino/Run (7).png')
                : Image.asset('assets/dino/Idle (1).png')),
      );
    }
  }
}
