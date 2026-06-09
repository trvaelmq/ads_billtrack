// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BillRecordAdapter extends TypeAdapter<BillRecord> {
  @override
  final int typeId = 0;

  @override
  BillRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BillRecord()
      ..id = fields[0] as String
      ..amount = fields[1] as double
      ..type = fields[2] as String
      ..category = fields[3] as String
      ..date = fields[4] as DateTime
      ..note = fields[5] as String
      ..tags = (fields[6] as List?)?.cast<String>()
      ..accountId = fields[7] as String?;
  }

  @override
  void write(BinaryWriter writer, BillRecord obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.note)
      ..writeByte(6)
      ..write(obj.tags)
      ..writeByte(7)
      ..write(obj.accountId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
