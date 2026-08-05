import 'package:bilibili_downloader/models/database.dart';
import 'package:flutter/material.dart';

import 'video_thumbnail.dart';

class VideoItem extends StatelessWidget {
  final DownloadVideoInfo info;
  final double thumbnailHeight;
  final double thumbnailWidth;

  const VideoItem(this.info,
      {super.key, this.thumbnailHeight = 56, this.thumbnailWidth = 100});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        VideoThumbnail(info.pic,
            height: thumbnailHeight, width: thumbnailWidth),
        const SizedBox(width: 12),
        Expanded(
          child: Text(info.title,
              style: const TextStyle(fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
