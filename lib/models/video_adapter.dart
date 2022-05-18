import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CancelTokenAdapter extends TypeAdapter<CancelToken> {
  @override
  final int typeId = 1;

  @override
  CancelToken read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return fields[0];
  }

  @override
  void write(BinaryWriter writer, CancelToken obj) {
    writer
      ..writeByte(0)
      ..write(obj);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CancelTokenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
