import 'package:flutter/material.dart';
import 'package:flutter_animation_playground/animations/parallax_scrolling_effect/constants/image_constants.dart';
import 'package:flutter_animation_playground/animations/parallax_scrolling_effect/widget/image_item_widget.dart';

class ParallaxScrollingExample extends StatefulWidget {
  const ParallaxScrollingExample({super.key});

  @override
  State<ParallaxScrollingExample> createState() =>
      _ParallaxScrollingExampleState();
}

class _ParallaxScrollingExampleState extends State<ParallaxScrollingExample> {
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          controller: scrollController,
          itemCount: ImageConstants.natureImages.length,
          itemBuilder: (context, index) {
            return ImageItemWidget(
              imageUrl: ImageConstants.natureImages[index],
              scrollController: scrollController,
              index: index,
            );
          },
        ),
      ),
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  final ScrollController scrollController;
  final BuildContext itemContext;
  final GlobalKey imageKey;
  ParallaxFlowDelegate({
    required this.scrollController,
    required this.itemContext,
    required this.imageKey,
  }) : super(repaint: scrollController);
  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) =>
      BoxConstraints.tightFor(
        width: constraints.maxWidth,
        height: constraints.maxHeight * 1.2,
      );

  @override
  void paintChildren(FlowPaintingContext context) {
    final scrollableBox =
        Scrollable.of(itemContext).context.findRenderObject() as RenderBox;
    final itemBox = itemContext.findRenderObject() as RenderBox;
    final itemOffset = itemBox.localToGlobal(
      Offset.zero,
      ancestor: scrollableBox,
    );
    final viewPortDimension = scrollController.position.viewportDimension;
    final scrollFraction = (itemOffset.dy / viewPortDimension).clamp(0.0, 1.0);
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);
    final backgroundSize =
        (imageKey.currentContext!.findRenderObject() as RenderBox).size;
    final itemSize = context.size;
    final childRect = verticalAlignment.inscribe(
      backgroundSize,
      Offset.zero & itemSize,
    );
    context.paintChild(
      0,
      transform:
          Transform.translate(offset: Offset(0.0, childRect.top)).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollController != oldDelegate.scrollController ||
        itemContext != oldDelegate.itemContext ||
        imageKey != oldDelegate.imageKey;
  }
}
