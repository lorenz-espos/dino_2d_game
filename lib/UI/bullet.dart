import 'package:flutter/material.dart';
import 'dart:math';

// ignore: must_be_immutable
class Mybullet extends StatelessWidget {
  double w = 45;
  double h = 45;
  int animate = 0;
  Mybullet(int animate) {
    this.animate = animate;
  }

  @override
  Widget build(BuildContext context) {
    switch (animate) {
      case 0:
        return Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(pi),
            child: Container(
              width: w,
              height: h,
              child: Image.asset('assets/enemy/Bullet_000.png'),
            ));
      case 1:
        return Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(pi),
            child: Container(
              width: w,
              height: h,
              child: Image.asset('assets/enemy/Bullet_001.png'),
            ));
      case 2:
        return Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(pi),
            child: Container(
              width: w,
              height: h,
              child: Image.asset('assets/enemy/Bullet_002.png'),
            ));
      case 3:
        return Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(pi),
            child: Container(
              width: w,
              height: h,
              child: Image.asset('assets/enemy/Bullet_003.png'),
            ));
    }
    return Container();
  }
}
