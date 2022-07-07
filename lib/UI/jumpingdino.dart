import 'package:flutter/material.dart';
import 'dart:math';

// ignore: must_be_immutable
class Myjumpingdino extends StatelessWidget {
  String direction = "right";
  Myjumpingdino(String direction) {
    this.direction = direction;
  }
  @override
  Widget build(BuildContext context) {
    if (direction == "right") {
      return Container(
          width: 90,
          height: 90,
          child: Image.asset('assets/dino/Jump (6).png'));
    } else {
      return Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(pi),
          child: Container(
            width: 90,
            height: 90,
            child: Image.asset('assets/dino/Jump (6).png'),
          ));
    }
  }
}
