import 'package:flutter/material.dart';

class AnimationProgressExample extends StatefulWidget {
  const AnimationProgressExample({super.key});

  @override
  State<AnimationProgressExample> createState() =>
      _AnimationProgressExampleState();
}

class _AnimationProgressExampleState extends State<AnimationProgressExample>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> sizeAnimation;
  late Animation<Color?> colorAnimation;
  late Animation<BorderRadius?> radiusAnimation;

  Duration duration = const Duration(milliseconds: 1500);
  Curve curve = Curves.easeInOut;

  @override
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: duration);

    animationSetup();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) controller.reverse();
        });
      } else if (status == AnimationStatus.dismissed) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) controller.forward();
        });
      }
    });

    controller.forward();
  }

  animationSetup() {
    CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: controller,
      curve: curve,
    );
    sizeAnimation = Tween<double>(
      begin: 200,
      end: 300,
    ).animate(curvedAnimation);
    colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.deepPurpleAccent,
    ).animate(curvedAnimation);
    radiusAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(8),
      end: BorderRadius.circular(50),
    ).animate(curvedAnimation);
  }

  void updateDuration(Duration duration) {
    setState(() {
      duration = duration;
      controller.duration = duration;
    });
  }

  void updateCurve(Curve curve) {
    setState(() {
      curve = curve;
      animationSetup();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(
              'Animation value ${(controller.value * 100).toStringAsFixed(0)}%',
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LinearProgressIndicator(
                value: controller.value,
                minHeight: 10,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color.lerp(
                        Colors.blueAccent,
                        Colors.purpleAccent,
                        controller.value,
                      ) ??
                      Colors.blueAccent,
                ),
              ),
            ),
            const SizedBox(height: 40),
            AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Container(
                  width: sizeAnimation.value,
                  height: sizeAnimation.value,
                  decoration: BoxDecoration(
                    color: colorAnimation.value,
                    borderRadius: radiusAnimation.value,
                  ),
                );
              },
            ),
            const Text('Duration'),

            Slider(
              value: duration.inMilliseconds.toDouble(),
              min: 500,
              max: 5000,
              divisions: 9,
              label: '${(duration.inMilliseconds / 1000).toStringAsFixed(0)}s',
              onChanged: (value) {
                updateDuration(Duration(milliseconds: value.round()));
              },
            ),
            const Text('Choose a curve'),
            DropdownButton<Curve>(
              value: curve,
              items: [
                DropdownMenuItem(value: Curves.linear, child: Text('Linear')),
                DropdownMenuItem(value: Curves.easeIn, child: Text('Ease In')),
                DropdownMenuItem(
                  value: Curves.easeOut,
                  child: Text('Ease Out'),
                ),
                DropdownMenuItem(
                  value: Curves.easeInOut,
                  child: Text('Ease In Out'),
                ),
                DropdownMenuItem(
                  value: Curves.bounceOut,
                  child: Text('Bounce Out'),
                ),
                DropdownMenuItem(
                  value: Curves.elasticOut,
                  child: Text('Elastic Out'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  updateCurve(value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
