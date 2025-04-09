import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedContainerExample extends StatefulWidget {
  const AnimatedContainerExample({super.key});

  @override
  State<AnimatedContainerExample> createState() =>
      _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample> {
  double boxWidth = 100.0;
  double boxHeight = 100.0;
  BorderRadius boxRadius = BorderRadius.circular(8);
  Color boxColor = Colors.deepPurpleAccent;
  bool isExpanded = false;
  double boxRotation = 0.0;
  Alignment boxAlignment = Alignment.center;
  Curve boxCurve = Curves.fastOutSlowIn;

  void changeContainerSize() {
    setState(() {
      boxWidth = Random().nextInt(400).toDouble();
      boxHeight = Random().nextInt(400).toDouble();
    });
  }

  void changeContainerColor() {
    setState(() {
      boxColor = Color.fromRGBO(
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        1,
      );
    });
  }

  void changeContainerRadius() {
    setState(() {
      boxRadius = BorderRadius.circular(Random().nextInt(80).toDouble());
    });
  }

  void changeTransformation() {
    setState(() {
      boxRotation = Random().nextInt(360).toDouble();
      boxAlignment = Alignment(
        Random().nextDouble() * 2 - 1,
        Random().nextDouble() * 2 - 1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            curve: boxCurve,
            width: boxWidth,
            height: boxHeight,
            decoration: BoxDecoration(color: boxColor, borderRadius: boxRadius),
            transform: Matrix4.rotationZ(boxRotation * 3.14159 / 180),
          ),

          Wrap(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: changeContainerColor,
                child: Text('Change Color'),
              ),
              TextButton(
                onPressed: changeContainerSize,
                child: Text('Change Size'),
              ),
              TextButton(
                onPressed: changeContainerRadius,
                child: Text('Change Radius'),
              ),

              TextButton(
                onPressed: changeTransformation,
                child: Text('Change Transformation'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
