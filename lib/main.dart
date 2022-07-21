import 'package:flutter/material.dart';
import 'UI/menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //preload of image (fix the glitch)
    precacheImage(Image.asset('assets/dino/Idle (1).png').image, context);
    precacheImage(Image.asset('assets/dino/Dead (1).png').image, context);
    precacheImage(Image.asset('assets/dino/Dead (2).png').image, context);
    precacheImage(Image.asset('assets/dino/Dead (3).png').image, context);
    precacheImage(Image.asset('assets/dino/Dead (4).png').image, context);
    precacheImage(Image.asset('assets/dino/Dead (5).png').image, context);
    precacheImage(Image.asset('assets/dino/Dead (6).png').image, context);
    precacheImage(Image.asset('assets/dino/Dead (7).png').image, context);
    precacheImage(Image.asset('assets/dino/Dead (8).png').image, context);

    return MaterialApp(
      title: 'Dino Demo',
      debugShowCheckedModeBanner: false,
      home: MyMenuPage(),
    );
  }
}
