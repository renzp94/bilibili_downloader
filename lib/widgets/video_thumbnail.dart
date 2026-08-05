import 'package:flutter/material.dart';

class VideoThumbnail extends StatelessWidget {
  final String image;
  final double height;
  final double width;

  const VideoThumbnail(this.image,
      {super.key, this.height = 56, this.width = 100});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Image.network(
        image,
        height: height,
        width: width,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => Container(
          height: height,
          width: width,
          color: Colors.white.withValues(alpha: 0.04),
          child: const Icon(Icons.broken_image,
              color: Colors.white24, size: 20),
        ),
      ),
    );
  }
}
