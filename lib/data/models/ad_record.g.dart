// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
part of 'ad_record.dart';

class AdRecordAdapter extends TypeAdapter<AdRecord> {
  @override
  final int typeId = 1;

  @override
  AdRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdRecord()
      ..id          = fields[0] as String
      ..adType      = fields[1] as String
      ..coinsEarned = fields[2] as int
      ..watchedAt   = fields[3] as DateTime;
  }

  @override
  void write(BinaryWriter writer, AdRecord obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.adType)
      ..writeByte(2)
      ..write(obj.coinsEarned)
      ..writeByte(3)
      ..write(obj.watchedAt);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdRecordAdapter && runtimeType == other.runtimeType && typeId == other.typeId;

  @override
  int get hashCode => typeId.hashCode;
}
