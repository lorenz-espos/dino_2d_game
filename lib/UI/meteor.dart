import 'package:flutter/material.dart';
import 'dart:math';

// ignore: must_be_immutable
class Mymeteor extends StatelessWidget {
  double w = 70;
  double h = 70;
  int animate = 0;
  Mymeteor(int animate) {
    this.animate = animate;
  }

  @override
  Widget build(BuildContext context) {
    switch (animate) {
      case 0:
        return Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(0),
            child: Container(
              width: w,
              height: h,
              child: Image.asset('assets/enemy/Meteor(1).png'),
            ));
      case 1:
        return Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(0),
            child: Container(
              width: w,
              height: h,
              child: Image.asset('assets/enemy/Meteor(2).png'),
            ));
    }
    return Container();
  }
}
