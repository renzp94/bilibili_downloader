import 'package:bilibili_downloader/constant.dart';
import 'package:bilibili_downloader/models/video.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DownloadManagePage extends StatefulWidget {
  const DownloadManagePage({Key? key}) : super(key: key);

  @override
  State<DownloadManagePage> createState() => _DownloadManagePageState();
}

class _DownloadManagePageState extends State<DownloadManagePage> {
  List<DownloadVideoInfo> _downloadList = [];
  @override
  void initState() {
    super.initState();
    Box<DownloadVideoInfo>? db = Hive.box(downloadBoxName);
    _downloadList = db.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 24, left: 24, right: 24),
          child: Text('下载管理'),
        ),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.only(top: 12, left: 12),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemBuilder: (BuildContext ctx, int index) {
                            DownloadVideoInfo item = _downloadList[index];
                            return Container(
                              margin: const EdgeInsets.only(
                                  top: 12, left: 12, bottom: 12, right: 24),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: 0.1,
                                    color: Colors.grey.withOpacity(0.2),
                                  ),
                                ],
                              ),
                              child: Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          item.pic,
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12),
                                          child: Text(item.title),
                                        ))
                                  ],
                                ),
                              )),
                            );
                          },
                          primary: false,
                          itemCount: _downloadList.length),
                    )
                  ],
                )))
      ],
    );
  }
}
