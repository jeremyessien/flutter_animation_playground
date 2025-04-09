import 'package:flutter/material.dart';
import 'package:flutter_animation_playground/animations/parallax_scrolling_effect/example.dart';

class ImageItemWidget extends StatefulWidget {
  const ImageItemWidget({
    super.key,
    required this.imageUrl,
    required this.scrollController,
    required this.index,
  });
  final String imageUrl;
  final ScrollController scrollController;

  final int index;

  @override
  State<ImageItemWidget> createState() => _ImageItemWidgetState();
}

class _ImageItemWidgetState extends State<ImageItemWidget> {
  final GlobalKey imagekey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Flow(
            delegate: ParallaxFlowDelegate(
              scrollController: widget.scrollController,
              imageKey: imagekey,
              itemContext: context,
            ),
            children: [
              Image.network(widget.imageUrl, fit: BoxFit.cover, key: imagekey),
            ],
          ),
        ),
      ),
    );
  }
}
