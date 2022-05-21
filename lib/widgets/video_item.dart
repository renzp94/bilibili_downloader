import 'package:bilibili_downloader/models/video.dart';
import 'package:flutter/material.dart';

import 'video_thumbnail.dart';

class VideoItem extends StatelessWidget {
  final DownloadVideoInfo info;

  const VideoItem(this.info, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        VideoThumbnail(info.pic),
        Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(info.title),
            ))
      ],
    );
  }
}
