import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_2d_game/UI/coin.dart';
import 'package:flutter_2d_game/UI/jumpingdino.dart';
import 'dino.dart';
import 'skyelements.dart';
import 'x2.dart';
import 'coin.dart';
import 'storage/storage.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double x = -1;
  double y = 1;
  bool firstmove = true;
  double move = 0;
  double cx = 0.8;
  double cx2 = 1.5;
  double cx3 = 2.2;
  double cx4 = 2.7;
  double cy = 1;
  double cy2 = 0.2;
  double v0 = 0.8;
  double t = 0;
  int m = 1;
  bool animate = true;
  bool jumping = false;
  static double g = 9.8;
  var score = 0;
  String direction = "right";
  bool running = true;
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    //disable system bars top and bottom
    Timer.periodic(
      Duration(milliseconds: 550),
      (timer) {
        setState(() {
          animate = !animate;
        });
      },
    );
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
        cx = cx + 2;
        score = m + score;
      });
    }
    if ((x - cx2).abs() < 0.05 && (y - cy).abs() < 0.05) {
      setState(() {
        //if you  catch the coin  add the score e move the coin off the screen
        cx2 = cx2 + 2;
        score = m + score;
      });
    }
    if ((x - cx3).abs() < 0.05 && (y - cy).abs() < 0.05) {
      setState(() {
        //if you catch the coin  add the score e move the coin off the screen
        cx3 = cx3 + 2;
        score = m + score;
      });
    }
    if ((x - cx4).abs() < 0.1 && (y - cy2).abs() < 0.1) {
      setState(() {
        //if you catch the x2  add the score e move the x2 off the screen
        score = score + 4;
        m = 2;
        cx4 = cx4 + 12;
      });
    }
    if (cx < -1) {
      cx = cx + 2;
    }
    if (cx2 < -1) {
      cx2 = cx2 + 2;
    }
    if (cx3 < -1) {
      cx3 = cx3 + 2;
    }
    if (cx4 < -12) {
      cx4 += 14;
    }
    if (m == 2) {
      Timer.periodic(Duration(seconds: 15), (timer) {
        m = 1;
        timer.cancel();
      });
    }
    CounterStorage().pushCounter(score);
  }

  void updaterunning() {
    running = !running;
  }

  void jump(double x0, double y0, String direction) {
    double d = 0;
    if (direction == "left") {
      d = pi;
    }
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
            // x = x0 + ((v0 * cos(d + pi / 3)) * t);
            if (direction == "right") {
              move = -0.2;
            } else {
              move = 0.2;
            }
            y = (-0.5 * g * pow(t, 2)) + (v0 * sin(d + pi / 3) * t) + y0;
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

  void coinmovement() {
    cx = cx + move;
    cx2 = cx2 + move;
    cx3 = cx3 + move;
    cx4 = cx4 + move;
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
          updaterunning();
          if (firstmove == true) {
            updatex(x + 0.05);
            firstmove = false;
          }
          updated("right");
          setState(() {
            move = -0.05;
            //speed up
            if (score > 3) {
              move = -0.07;
            }
            //second speed up
            if (score > 10) {
              move = -0.09;
            }
            coinmovement();
          });
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
          jump(x, y, direction);
          coinmovement();
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
          updaterunning();
          //updatex(x - 0.05);
          updated("left");
          setState(() {
            move = 0.08;
            coinmovement();
          });
          Timer.periodic(Duration(milliseconds: 100), (timer) {
            addscore();
          });
        },
      ),
    );
  }

  Widget coin(double cx, double cy) {
    return Container(
      alignment: Alignment(cx, cy),
      child: Mycoin(animate),
    );
  }

  Widget x2(double cx, double cy) {
    return Container(
      alignment: Alignment(cx, cy),
      child: Myx2(animate),
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
                    child: jumping
                        ? Myjumpingdino(direction)
                        : Mydino(direction, running),
                  ),
                ),
                coin(cx, cy),
                coin(cx2, cy),
                coin(cx3, cy),
                x2(cx4, cy2),
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
