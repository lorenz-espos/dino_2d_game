import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dino.dart';
import 'skyelements.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double x = -1;
  double y = 1;
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

  void updaterunning() {
    running = !running;
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
        onPressed: () {},
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
                  child: Text('SCORE $score',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 32)),
                ),
                cloud(),
              ],
            ),
            Expanded(
              child: AnimatedContainer(
                duration: Duration(microseconds: 0),
                alignment: Alignment(x, y),
                child: Mydino(direction, running),
              ),
            ),
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
