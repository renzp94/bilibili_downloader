import 'package:bilibili_downloader/api/video.dart';
import 'package:bilibili_downloader/constant.dart';
import 'package:bilibili_downloader/models/video.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DownloadManagePage extends StatefulWidget {
  const DownloadManagePage({Key? key}) : super(key: key);

  @override
  State<DownloadManagePage> createState() => _DownloadManagePageState();
}

class _DownloadManagePageState extends State<DownloadManagePage>
    with AutomaticKeepAliveClientMixin {
  List<DownloadVideoInfo> _downloadList = [];
  @override
  void initState() {
    super.initState();
    Box<DownloadVideoInfo>? db = Hive.box<DownloadVideoInfo>(downloadBoxName);
    _downloadList = db.values.toList();
    loopDownload();
  }

  void loopDownload() async {
    // 拿到准备下载的视频
    var downloadIndexList = _downloadList
        .where((element) => element.status == 'downloading')
        .map((downloadItem) => _downloadList
            .indexWhere((element) => downloadItem.cid == element.cid))
        .toList();

    if (downloadIndexList.isNotEmpty) {
      // 放入下载队列中
      dynamic futureList =
          downloadIndexList.map((index) => analysisOneVideo(index)).toList();
      await Future.wait(futureList);
      setState(() {
        List<DownloadVideoInfo> list =
            _downloadList.where((element) => element.status == 'wait').toList();

        if (list.isNotEmpty) {
          int count = list.length > defaultMaxDownloadCount
              ? defaultMaxDownloadCount
              : list.length;
          List<int> cidList = list.sublist(0, count).map((e) => e.cid).toList();

          _downloadList = _downloadList.map((element) {
            if (cidList.contains(element.cid)) {
              element.status = 'downloading';
            }

            return element;
          }).toList();
          loopDownload();
        }
      });
    }
  }

  Future<Response<dynamic>> analysisOneVideo(int index) async {
    Box<CancelToken> cancelTokenDB = Hive.box<CancelToken>(cancelTokenBoxName);
    DownloadVideoInfo videoInfo = _downloadList[index];
    String uri = await getVideoDownloadUri(videoInfo.bvid, videoInfo.cid);
    videoInfo.uri = uri;
    cancelTokenDB.put(videoInfo.cid, CancelToken());
    return download(index);
  }

  Future<Response<dynamic>> download(int index) {
    DownloadVideoInfo videoInfo = _downloadList[index];
    Box<DownloadVideoInfo> db = Hive.box<DownloadVideoInfo>(downloadBoxName);
    Box<CancelToken> cancelTokenDB = Hive.box<CancelToken>(cancelTokenBoxName);

    return downloadVideo(
        uri: videoInfo.uri!,
        filename: videoInfo.title,
        cancelToken: cancelTokenDB.get(videoInfo.cid),
        onReceiveProgress: (int count, int total) {
          videoInfo.process = count / total;
          if (videoInfo.process == 1) {
            videoInfo.status = "done";
          }
          _downloadList[index] = videoInfo;
          db.putAt(index, videoInfo);
          setState(() {
            _downloadList[index] = videoInfo;
          });
        });
  }

  Future<String> getVideoDownloadUri(String bvid, int cid) async {
    Response<dynamic> res = await fetchDownloadVideoInfo(bvid, cid);
    return res.data['data']['durl'][0]['url'];
  }

  @override
  bool get wantKeepAlive => true;

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
                                child: Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.network(
                                                item.pic,
                                                height: 100,
                                                width: 100,
                                                fit: BoxFit.cover,
                                              )),
                                          Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12),
                                                child: Text(item.title),
                                              ))
                                        ],
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8)),
                                      child: LinearProgressIndicator(
                                        color: item.process == 1
                                            ? Colors.green
                                            : Colors.blue,
                                        backgroundColor: Colors.transparent,
                                        value: item.process,
                                      ),
                                    ),
                                  ],
                                ));
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
