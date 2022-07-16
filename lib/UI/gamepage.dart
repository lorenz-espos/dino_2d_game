import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_2d_game/UI/bullet.dart';
import 'package:flutter_2d_game/UI/coin.dart';
import 'package:flutter_2d_game/UI/jumpingdino.dart';
import 'dino.dart';
import 'skyelements.dart';
import 'x2.dart';
import 'coin.dart';
import 'storage/storage.dart';
import 'gameover.dart';

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
  bool moltiply = false;
  double cx2 = 1.5;
  double cx3 = 2.2;
  double cx4 = 4.7;
  double cy = 1;
  double cy2 = -0.6;
  double bx = 1;
  double by = 1;
  double v0 = 0.2;
  bool start = false;
  double t = 0;
  int m = 1;
  bool animate = true;
  bool jumping = false;
  int jumpv = 1;
  var score = 0;
  int running = 0;
  int bulleta = 0;
  int distance = 0;
  double bmove = -0.015;
  Random random = new Random();

  void initState() {
    start = true;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    //disable system bars top and bottom
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    //disable rotation of screen
    Timer.periodic(
      Duration(milliseconds: 550),
      (timer) {
        setState(() {
          animate = !animate;
          bulleta++;
          if (bulleta == 4) {
            bulleta = 0;
          }
        });
      },
    );
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      run();
    });

    super.initState();
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
        moltiply = true;
        cx4 = cx4 + 32;
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
      cx4 += 34;
    }
    if (m == 2) {
      Timer.periodic(Duration(seconds: 15), (timer) {
        m = 1;
        moltiply = false;
        timer.cancel();
      });
    }
    CounterStorage().pushCounter(score);
  }

  void death() {
    if ((x - bx).abs() < 0.05 && (y - by).abs() < 0.05) {
      setState(() {
        start = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Gameover()),
      );
    }
    if (bx < -1) {
      bx = bx + random.nextInt(18) + 2;
    }
  }

  void updaterunning() {
    running++;
    if (running == 9) {
      running = 1;
    }
  }

  void updatejump() {
    jumpv++;
    if (jumpv == 13) {
      jumpv = 1;
    }
  }

  void prejump() {
    start = false;
    t = 0;
    sleep(Duration(milliseconds: 10));
    //introducing delay in the jump
  }

  void postjump() {
    start = true;
    sleep(Duration(milliseconds: 10));
    //introducing delay in the jump
  }

  void jump(double x0, double y0) {
    if (jumping == true) {
      return;
    } else {
      jumping = true;
      Timer.periodic(
        Duration(milliseconds: 50),
        (timer) {
          t += 0.05;
          updatejump();

          /// Navigate to seconds screen when timer callback in executed
          setState(() {
            y = y0 - ((-4.6 * pow(t, 2)) + (6.2 * t));
          });
          if (y > 1) {
            updatey(1);
            t = 0;
            timer.cancel();
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
    cx4 = cx4 + move; //x2 movement
    bx = bx + move + bmove; //bullet movement
  }

  void run() {
    if (start == true) {
      updaterunning();
      if (firstmove == true) {
        updatex(x + 0.05);
        firstmove = false;
        sleep(Duration(milliseconds: 100));
      }
      setState(() {
        if (distance < 300) {
          move = -0.02;
        }
        if (distance > 600 && distance < 1000) {
          move = -0.05;
          bmove = -0.03;
        }
        if (distance > 1000) {
          move = -0.07;
        }

        coinmovement();
        distance++;
      });
      Timer.periodic(Duration(milliseconds: 30), (timer) {
        addscore();
        death();
        timer.cancel();
      });
    }
  }

/*
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
          prejump();
          jump(x, y);
          coinmovement();
          postjump();
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
*/
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

  Widget bullet(double bx, double by) {
    return Container(
      alignment: Alignment(bx, by),
      child: Mybullet(bulleta),
    );
  }

  Widget ground() {
    return Expanded(
        flex: 3,
        child: GestureDetector(
          onTap: () {
            prejump();
            jump(x, y);
            coinmovement();
            postjump();
          },
          child: Container(
            /* child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // buttonBackward(),
                buttonUpward(),
                // buttonForward(),
              ],
            ),
            */
            color: Colors.brown,
          ),
        ));
  }

  Widget green() {
    return Container(
      color: Colors.green,
      height: 10,
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
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 2),
                            child: Text('SCORE  $score ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20)),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 2),
                            child: Text(' DISTANCE  $distance',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20)),
                          ),
                        ],
                      ),
                      Container(
                        child: moltiply ? Myx2(true) : null,
                      ),
                    ],
                  ),
                ),
                cloud(),
              ],
            ),
            Expanded(
                child: Stack(
              children: [
                Container(
                  child: AnimatedContainer(
                    duration: Duration(microseconds: 0),
                    alignment: Alignment(x, y),
                    child: jumping ? Myjumpingdino(jumpv) : Mydino(running),
                  ),
                ),
                coin(cx, cy),
                coin(cx2, cy),
                coin(cx3, cy),
                x2(cx4, cy2),
                bullet(bx, by),
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
