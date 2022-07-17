import 'dart:async';
import 'package:flutter_2d_game/UI/menu.dart';

import 'dinodeath.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Gameover extends StatefulWidget {
  @override
  _GameoverState createState() => _GameoverState();
}

class _GameoverState extends State<Gameover> {
  int animate = 0;

  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    //disable system bars top and bottom
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    //disable rotation of screen
    super.initState();
    death();
  }

  void death() {
    Timer.periodic(Duration(milliseconds: 80), (timer) {
      setState(() {
        if (animate < 7) {
          animate++;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyMenuPage()),
            );
          },
          child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment(0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Text('G A M E   O V E R',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 40)),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Mydinodeath(animate),
                    ],
                  )
                ],
              ))),
    );
  }
}
