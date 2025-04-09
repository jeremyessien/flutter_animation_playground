import 'package:flutter/material.dart';
import 'package:flutter_animation_playground/animations/animated_container/animation_progress.dart';
import 'package:flutter_animation_playground/animations/animated_container/example.dart';
import 'package:flutter_animation_playground/animations/parallax_scrolling_effect/example.dart';
import 'package:flutter_animation_playground/animations/pinch_to_zoom_image/widget/image_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: PinchZoomImage(),
    );
  }
}
