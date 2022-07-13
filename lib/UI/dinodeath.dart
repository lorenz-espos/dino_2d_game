import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Mydinodeath extends StatelessWidget {
  int animate = 0;
  Mydinodeath(int animate) {
    this.animate = animate;
  }

  @override
  Widget build(BuildContext context) {
    switch (animate) {
      case 0:
        return Container(
          width: 180,
          height: 180,
          child: Image.asset('assets/dino/Dead (1).png'),
        );
      case 1:
        return Container(
          width: 180,
          height: 180,
          child: Image.asset('assets/dino/Dead (2).png'),
        );
      case 2:
        return Container(
          width: 180,
          height: 180,
          child: Image.asset('assets/dino/Dead (3).png'),
        );
      case 3:
        return Container(
          width: 180,
          height: 180,
          child: Image.asset('assets/dino/Dead (4).png'),
        );
      case 4:
        return Container(
          width: 180,
          height: 180,
          child: Image.asset('assets/dino/Dead (5).png'),
        );
      case 5:
        return Container(
          width: 190,
          height: 190,
          child: Image.asset('assets/dino/Dead (6).png'),
        );
      case 6:
        return Container(
          width: 190,
          height: 190,
          child: Image.asset('assets/dino/Dead (7).png'),
        );
      case 7:
        return Container(
          width: 190,
          height: 190,
          child: Image.asset('assets/dino/Dead (8).png'),
        );
    }
    return Container();
  }
}
