import 'package:flutter/material.dart';
import 'skyelements.dart';
import 'package:flutter/services.dart';
import 'dino.dart';
import 'gamepage.dart';
import 'dart:async';
import 'storage/storage.dart';

class MyMenuPage extends StatefulWidget {
  @override
  _MyMenuPageState createState() => _MyMenuPageState();
}

class _MyMenuPageState extends State<MyMenuPage> {
  String direction = "right";
  int running = 0; //dino in idle pose
  double x = -1;
  double y = 1;
  int score = 0;
  bool animate = true;
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: []); //disable system bars top and bottom
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    //disable rotation of screen
    updateScore();
    super.initState();
    Timer.periodic(
      Duration(milliseconds: 550),
      (timer) {
        /// Navigate to seconds screen when timer callback in executed
        setState(() {
          animate = !animate;
        });
      },
    );
  }

  void updateScore() async {
    score = await CounterStorage().readCounter();
  }

  Widget sky(double x, double y, BuildContext context) {
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
                  child: Text('LAST SCORE  $score',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 32)),
                ),
                cloud(),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.yellowAccent.withOpacity(0.5),
                      spreadRadius: 7,
                      blurRadius: 7,
                      offset: Offset(3, 3), // changes position of shadow
                    ),
                  ],
                  color: Colors.red.shade700,
                ),
                child: Stack(
                  children: [
                    AnimatedDefaultTextStyle(
                      child: Text('T A P  T O  P L A Y'),
                      style: animate
                          ? TextStyle(
                              fontSize: 30,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 6
                                ..color = Colors.tealAccent,
                            )
                          : TextStyle(
                              fontSize: 40,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 6
                                ..color = Colors.yellowAccent,
                              wordSpacing: 3.5),
                      duration: Duration(milliseconds: 200),
                    ),
                    AnimatedDefaultTextStyle(
                      child: Text('T A P  T O  P L A Y'),
                      style: animate
                          ? TextStyle(
                              fontSize: 30,
                              color: Colors.yellowAccent,
                            )
                          : TextStyle(
                              fontSize: 40,
                              color: Colors.tealAccent,
                              wordSpacing: 3.5),
                      duration: Duration(milliseconds: 200),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: AnimatedContainer(
                duration: Duration(microseconds: 0),
                alignment: Alignment(x, y),
                child: Mydino(running),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget green() {
    return Container(
      color: Colors.green,
      height: 10,
    );
  }

  Widget ground() {
    return Expanded(
      flex: 3,
      child: Container(
        color: Colors.brown,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          sky(x, y, context),
          green(),
          ground(),
        ],
      ),
    );
  }
}
