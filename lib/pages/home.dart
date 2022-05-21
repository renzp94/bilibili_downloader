import 'package:bilibili_downloader/constant.dart';
import 'package:bilibili_downloader/models/video.dart';
import 'package:bilibili_downloader/store/store.dart';
import 'package:bilibili_downloader/utils/tools.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../api/video.dart';
import '../widgets/video_item.dart';
import 'routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _url = '';
  List<DownloadVideoInfo> _list = [];
  List<dynamic> _checkedList = [];

  void onVideoItemTap(DownloadVideoInfo item) {
    setState(() {
      if (_checkedList.contains(item.cid)) {
        _checkedList.remove(item.cid);
      } else {
        _checkedList.add(item.cid);
      }
    });
  }

  // 根据视频url获取视频列表
  void onSearch(String url) async {
    if (url.isNotEmpty) {
      // 判断是否为bilibili网站
      if (!url.contains(videoUrlPrefix)) {
        warningTips('请输入正确的bilibili视频链接');
        return;
      }

      getVideoList(url);
    }
  }

  void getVideoList(String url) async {
    String bvid = url
        .substring(videoUrlPrefix.length,
            url.contains("?") ? url.indexOf("?") : url.length)
        .replaceAll('/', '');

    Dio.Response res = await fetchVideoList(bvid);

    dynamic data = res.data['data'];
    setState(() {
      _url = url;
      // 分p
      if (data['videos'] > 1) {
        dynamic list = data['pages'].asMap().keys;
        _list = list
            .map<DownloadVideoInfo>((i) => DownloadVideoInfo(
                bvid: bvid,
                aid: data['aid'],
                pic: data['pic'],
                cid: data['pages'][i]['cid'],
                title: "P${i}_${data['pages'][i]['part']}",
                process: 0,
                status: i < defaultMaxDownloadCount ? 'downloading' : 'wait'))
            .toList();

        _checkedList = list.map((i) => data['pages'][i]['cid']).toList();
      } else {
        _list = [
          DownloadVideoInfo(
              bvid: bvid,
              aid: data['aid'],
              pic: data['pic'],
              cid: data['pages'][0]['cid'],
              title: data['title'],
              process: 0,
              status: 'downloading')
        ];
        _checkedList = [data['pages'][0]['cid']];
      }
    });
  }

  void onDownload() async {
    List<DownloadVideoInfo> list =
        _list.where((item) => _checkedList.contains(item.cid)).toList();

    Box<DownloadVideoInfo> db = Hive.box<DownloadVideoInfo>(downloadBoxName);
    List<int> cidList = db.values.map((e) => e.cid).toList();
    for (var item in list) {
      if (!cidList.contains(item.cid)) {
        db.add(item);
      }
    }
    Store.to.animateToPage(Pages.downloadManage);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
          child: Row(children: [
            Expanded(
                child: TextField(
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.blue)),
                hintText: '请输入视频链接，按回车键搜索',
              ),
              onSubmitted: onSearch,
            )),
            Container(
              height: 54,
              padding: const EdgeInsets.only(left: 12),
              child: ElevatedButton(
                onPressed: _checkedList.isNotEmpty ? onDownload : null,
                child: const Text('下载'),
              ),
            )
          ]),
        ),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.only(top: 12, left: 12),
                child: Column(
                  children: [
                    _url.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(left: 12, bottom: 4),
                            child: Row(
                              children: [
                                Text(
                                    "共${_list.length}个视频，已选中${_checkedList.length}个")
                              ],
                            ),
                          )
                        : const SizedBox(),
                    Expanded(
                      child: ListView.builder(
                          itemBuilder: (BuildContext ctx, int index) {
                            DownloadVideoInfo item = _list[index];
                            return InkWell(
                              onTap: () => onVideoItemTap(item),
                              child: Container(
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
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                          hoverColor: Colors.transparent,
                                          fillColor: MaterialStateProperty.all(
                                              Colors.white.withOpacity(0.5)),
                                          checkColor: Colors.blue,
                                          value:
                                              _checkedList.contains(item.cid),
                                          onChanged: (v) {
                                            if (v != null) {
                                              onVideoItemTap(item);
                                            }
                                          }),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: VideoItem(item),
                                      ))
                                    ]),
                              ),
                            );
                          },
                          primary: false,
                          itemCount: _list.length),
                    )
                  ],
                )))
      ],
    );
  }
}
