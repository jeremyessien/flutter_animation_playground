import 'package:flutter/material.dart';
import 'package:flutter_animation_playground/animations/parallax_scrolling_effect/constants/image_constants.dart';

class PinchZoomImage extends StatefulWidget {
  const PinchZoomImage({super.key});

  @override
  State<PinchZoomImage> createState() => _PinchZoomImageState();
}

class _PinchZoomImageState extends State<PinchZoomImage>
    with SingleTickerProviderStateMixin {
  late TransformationController controller;
  late AnimationController animationController;
  Animation<Matrix4>? animation;
  final double minScale = 1;
  final double maxScale = 4;

  @override
  void initState() {
    controller = TransformationController();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )..addListener(() => controller.value = animation!.value);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    animationController.dispose();
    super.dispose();
  }

  void resetAnimation() {
    animation = Matrix4Tween(
      begin: controller.value,
      end: Matrix4.identity(),
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInCirc),
    );
    animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: InteractiveViewer(
            clipBehavior: Clip.none,
            panEnabled: false,
            minScale: minScale,
            maxScale: maxScale,
            onInteractionEnd: (value) {
              resetAnimation();
            },
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  ImageConstants.natureImages[2],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
