import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/tools.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const ListTile(
          minLeadingWidth: 12,
          leading: Icon(
            Icons.help_rounded,
            color: Colors.black,
            size: 36,
          ),
          title: Text('关于',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        ),
        const Padding(
            padding: EdgeInsets.only(top: 24, left: 72),
            child: Text(
              'BiliDown是基于Flutter开发的开源、跨平台的Bilibili视频下载工具',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            )),
        Padding(
            padding: const EdgeInsets.only(top: 24, left: 54),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ListTile(
                  leading: Icon(Icons.verified),
                  minLeadingWidth: 12,
                  title: Text('版本'),
                  subtitle: Text("V0.1.0"),
                ),
                const ListTile(
                  leading: Icon(Icons.person),
                  minLeadingWidth: 12,
                  title: Text('作者'),
                  subtitle: Text("renzp94"),
                ),
                ListTile(
                  leading: const Icon(Icons.cabin),
                  minLeadingWidth: 12,
                  title: const Text('仓库'),
                  subtitle: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                            "https://github.com/renzp94/bilibili_downloader"),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: InkWell(
                            child: const Icon(
                              Icons.copy,
                              size: 14,
                            ),
                            onTap: () {
                              Clipboard.setData(const ClipboardData(
                                  text:
                                      "https://github.com/renzp94/bilibili_downloader"));
                              successTips('复制成功');
                            },
                          ),
                        )
                      ]),
                ),
              ],
            )),
      ]),
    );
  }
}
