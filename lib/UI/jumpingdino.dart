import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Myjumpingdino extends StatelessWidget {
  int jump = 1;
  double h = 95;
  double w = 95;
  Myjumpingdino(int jump) {
    this.jump = jump;
  }
  @override
  Widget build(BuildContext context) {
    switch (jump) {
      case 1:
        return Container(
          width: w,
          height: h,
          child: Image.asset('assets/dino/Jump (1).png'),
        );
      case 2:
        return Container(
          width: w,
          height: h,
          child: Image.asset('assets/dino/Jump (2).png'),
        );
      case 3:
        return Container(
          width: w,
          height: h,
          child: Image.asset('assets/dino/Jump (3).png'),
        );
      case 4:
        return Container(
          width: w,
          height: h,
          child: Image.asset('assets/dino/Jump (4).png'),
        );
      case 5:
        return Container(
          width: w,
          height: h,
          child: Image.asset('assets/dino/Jump (5).png'),
        );
      case 6:
        return Container(
          width: w,
          height: h,
          child: Image.asset('assets/dino/Jump (6).png'),
        );
      case 7:
        return Container(
          width: w,
          height: h,
          child: Image.asset('assets/dino/Jump (7).png'),
        );
      case 8:
        return Container(
          width: w,
          height: h,
          child: Image.asset('assets/dino/Jump (8).png'),
        );
      case 9:
        return Container(
          width: w,
          height: h,
          child: Image.asset('assets/dino/Jump (9).png'),
        );
      case 10:
        return Container(
          width: w,
          height: h,
          child: Image.asset('assets/dino/Jump (10).png'),
        );
      case 11:
        return Container(
          width: w,
          height: h,
          child: Image.asset('assets/dino/Jump (11).png'),
        );
      case 12:
        return Container(
          width: w,
          height: h,
          child: Image.asset('assets/dino/Jump (12).png'),
        );
    }
    /*
  Widget build(BuildContext context) {
    return Container(
        width: 90, height: 90, child: Image.asset('assets/dino/Jump (6).png'));
  }
  */

    return Container();
  }
}
