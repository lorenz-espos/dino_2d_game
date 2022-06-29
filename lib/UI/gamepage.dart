import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_2d_game/UI/coin.dart';
import 'package:flutter_2d_game/UI/jumpingdino.dart';
import 'dino.dart';
import 'skyelements.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double x = -1;
  double y = 1;
  double cx = 0.8;
  double cy = 1;
  double v0 = 0.8;
  double t = 0;
  bool jumping = false;
  static double g = 9.8;
  int score = 0;
  String direction = "right";
  bool running = true;
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays(
        []); //disable system bars top and bottom
    super.initState();
  }

  void updated(String direction) {
    if (x == -1) {
      direction = "right";
    }
    setState(() {
      this.direction = direction;
    });
  }

  void updatex(double x) {
    if (x > 1) {
      x = 1;
    }
    if (x < -1) {
      x = -1;
    }
    setState(() {
      this.x = x;
    });
  }

  void updatey(double y) {
    setState(() {
      this.y = y;
    });
  }

  void addscore() {
    if ((x - cx).abs() < 0.05 && (y - cy).abs() < 0.05) {
      setState(() {
        //if you catch the coin  add the score e move the coin off the screen
        score++;
        cx = cx + 1;
      });
    }
  }

  void updaterunning() {
    running = !running;
  }

  void jump(double x0, double y0) {
    if (jumping == true) {
      return;
    } else {
      jumping = true;
      Timer.periodic(
        Duration(milliseconds: 50),
        (timer) {
          t += 0.08;

          /// Navigate to seconds screen when timer callback in executed
          setState(() {
            x = x0 + ((v0 * cos(pi / 3)) * t);
            y = (-0.5 * g * pow(t, 2)) + (v0 * sin(pi / 3) * t) + y0;
          });
          if (y0 - y > 1) {
            updatey(1);
            timer.cancel();
            t = 0;
            jumping = false;
          }
          addscore();
        },
      );
    }
  }

  Widget buttonForward() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.brown.shade200,
      ),
      padding: EdgeInsets.all(5),
      child: IconButton(
        tooltip: 'Run Forward',
        icon: Icon(
          Icons.arrow_forward,
          size: 35,
          color: Colors.white,
        ),
        onPressed: () {
          x += 0.2;
          updatex(x);
          updated("right");
          updaterunning();
          Timer.periodic(Duration(milliseconds: 100), (timer) {
            addscore();
          });
        },
      ),
    );
  }

  Widget buttonUpward() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.brown.shade200,
      ),
      padding: EdgeInsets.all(5),
      child: IconButton(
        tooltip: 'Jump',
        icon: Icon(
          Icons.arrow_upward,
          size: 35,
          color: Colors.white,
        ),
        onPressed: () {
          jump(x, y);
        },
      ),
    );
  }

  Widget buttonBackward() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.brown.shade200,
      ),
      padding: EdgeInsets.all(5),
      child: IconButton(
        tooltip: 'Run back',
        icon: Icon(
          Icons.arrow_back,
          size: 35,
          color: Colors.white,
        ),
        onPressed: () {
          x -= 0.2;
          updatex(x);
          updated("left");
          updaterunning();
          Timer.periodic(Duration(milliseconds: 100), (timer) {
            addscore();
          });
        },
      ),
    );
  }

  Widget ground() {
    return Expanded(
      flex: 3,
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buttonBackward(),
            buttonUpward(),
            buttonForward(),
          ],
        ),
        color: Colors.brown,
      ),
    );
  }

  Widget green() {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.green,
      ),
    );
  }

  Widget sky(double x, double y) {
    return Expanded(
      flex: 12,
      child: Container(
        color: Colors.blue,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                sun(),
                Container(
                  child: Text('SCORE  $score',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 32)),
                ),
                cloud(),
              ],
            ),
            Expanded(
                child: Stack(
              children: [
                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(microseconds: 0),
                    alignment: Alignment(x, y),
                    child:
                        jumping ? Myjumpingdino() : Mydino(direction, running),
                  ),
                ),
                Container(
                  alignment: Alignment(cx, cy),
                  child: Mycoin(),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          sky(x, y),
          green(),
          ground(),
        ],
      ),
    );
  }
}
