import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Myx2 extends StatelessWidget {
  double w = 90;
  double h = 90;
  double w2 = 120;
  double h2 = 120;
  bool animate = true;
  Myx2(bool animate) {
    this.animate = animate;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: animate ? w : w2,
      height: animate ? h : h2,
      child: Image.asset(
        'assets/sky/x2.png',
      ),
    );
  }
}
