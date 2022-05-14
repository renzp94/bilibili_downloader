import 'package:bilibili_downloader/api/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<dynamic> _list = [];
  List<dynamic> _checkedList = [];

  void fetchVideoList(String url) async {
    if (url.isNotEmpty) {
      // 判断是否为bilibili网站
      if (!url.contains('https://www.bilibili.com/video/')) {
        Get.snackbar('', '请输入正确的bilibili视频链接',
            titleText: Text(
              '警告',
              style: TextStyle(
                  color: Colors.amber.shade900, fontWeight: FontWeight.w900),
            ),
            icon: Icon(
              Icons.warning,
              color: Colors.amber.shade900,
            ),
            snackPosition: SnackPosition.TOP,
            maxWidth: 300,
            duration: const Duration(milliseconds: 1500),
            animationDuration: const Duration(milliseconds: 300));
        return;
      }

      String bvid = url
          .substring('https://www.bilibili.com/video/'.length, url.indexOf("?"))
          .replaceAll('/', '');

      Dio.Response res = await dio
          .get('/x/web-interface/view', queryParameters: {"bvid": bvid});

      dynamic data = res.data['data'];
      // 分p
      if (data['videos'] > 1) {
        dynamic list = data['pages'].asMap().keys;
        setState(() {
          _list = list
              .map((i) => {
                    "bvid": bvid,
                    "aid": data['aid'],
                    "pic": data['pic'],
                    "cid": data['pages'][i]['cid'],
                    'title': "P${i}_${data['pages'][i]['part']}",
                  })
              .toList();

          _checkedList = list.map((i) => data['pages'][i]['cid']).toList();
        });
      } else {
        setState(() {
          _list = [
            {
              "bvid": bvid,
              "aid": data['aid'],
              "pic": data['pic'],
              "cid": data['pages'][0]['cid'],
              "title": data['title'],
            }
          ];
          _checkedList = [data['pages'][0]['cid']];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
          child: TextField(
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: Colors.blue)),
              hintText: '请输入视频链接',
            ),
            onSubmitted: fetchVideoList,
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(top: 12, left: 12),
          child: ListView.builder(
              itemBuilder: (BuildContext ctx, int index) {
                dynamic item = _list[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      if (_checkedList.contains(item['cid'])) {
                        _checkedList.remove(item['cid']);
                      } else {
                        _checkedList.add(item['cid']);
                      }
                    });
                  },
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                              hoverColor: Colors.transparent,
                              fillColor: MaterialStateProperty.all(
                                  Colors.white.withOpacity(0.5)),
                              checkColor: Colors.blue,
                              value: _checkedList.contains(item['cid']),
                              onChanged: (v) {
                                if (v != null) {
                                  setState(() {
                                    if (_checkedList.contains(item['cid'])) {
                                      _checkedList.remove(item['cid']);
                                    } else {
                                      _checkedList.add(item['cid']);
                                    }
                                  });
                                }
                              }),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      item["pic"],
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: Text(item["title"]),
                                    ))
                              ],
                            ),
                          ))
                        ]),
                  ),
                );
              },
              primary: false,
              itemCount: _list.length),
        ))
      ],
    );
  }
}
