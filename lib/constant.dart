// api
const baseUrl = 'https://api.bilibili.com';
// video url前缀
const videoUrlPrefix = "https://www.bilibili.com/video/";
// 默认最大下载量
const defaultMaxDownloadCount = 5;
const defaultDownloadDir = 'biliDown';
// 默认视频画质 (80 = 1080P)
const defaultQuality = 80;
// 画质选项（从高到低）
const qualityOptions = [
  (120, '4K'),
  (112, '1080P 高码率'),
  (80, '1080P'),
  (64, '720P'),
  (32, '480P'),
  (16, '360P'),
];
