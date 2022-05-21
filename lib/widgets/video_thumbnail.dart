import 'package:flutter/material.dart';

class VideoThumbnail extends StatelessWidget {
  final String image;

  const VideoThumbnail(this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          image,
          height: 100,
          width: 140,
          fit: BoxFit.cover,
        ));
  }
}
