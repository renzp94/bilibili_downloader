// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DownloadVideoInfoAdapter extends TypeAdapter<DownloadVideoInfo> {
  @override
  final int typeId = 0;

  @override
  DownloadVideoInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DownloadVideoInfo(
      bvid: fields[0] == null ? '' : fields[0] as String,
      aid: fields[1] == null ? -1 : fields[1] as int,
      pic: fields[2] == null ? '' : fields[2] as String,
      cid: fields[3] == null ? -1 : fields[3] as int,
      title: fields[4] == null ? '' : fields[4] as String,
    )..uri = fields[5] as String?;
  }

  @override
  void write(BinaryWriter writer, DownloadVideoInfo obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.bvid)
      ..writeByte(1)
      ..write(obj.aid)
      ..writeByte(2)
      ..write(obj.pic)
      ..writeByte(3)
      ..write(obj.cid)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.uri);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadVideoInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
