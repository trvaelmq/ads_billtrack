// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountRecordAdapter extends TypeAdapter<AccountRecord> {
  @override
  final int typeId = 3;

  @override
  AccountRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountRecord()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..emoji = fields[2] as String
      ..balance = fields[3] as double
      ..createdAt = fields[4] as DateTime
      ..sortOrder = fields[5] as int;
  }

  @override
  void write(BinaryWriter writer, AccountRecord obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.emoji)
      ..writeByte(3)
      ..write(obj.balance)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.sortOrder);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
