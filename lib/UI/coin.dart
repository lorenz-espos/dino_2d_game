import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Mycoin extends StatelessWidget {
  double w = 52;
  double h = 52;
  double w2 = 56;
  double h2 = 56;
  bool animate = true;
  Mycoin(bool animate) {
    this.animate = animate;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: animate ? w : w2,
      height: animate ? h : h2,
      child: animate
          ? Image.asset('assets/sky/coin2.png')
          : Image.asset('assets/sky/coin1.png'),
    );
  }
}
