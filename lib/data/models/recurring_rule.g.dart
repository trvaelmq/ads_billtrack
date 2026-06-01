// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_rule.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecurringRuleAdapter extends TypeAdapter<RecurringRule> {
  @override
  final int typeId = 2;

  @override
  RecurringRule read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecurringRule()
      ..id = fields[0] as String
      ..title = fields[1] as String
      ..amount = fields[2] as double
      ..category = fields[3] as String
      ..isExpense = fields[4] as bool
      ..frequency = fields[5] as String
      ..nextDueDate = fields[6] as DateTime
      ..isActive = fields[7] as bool
      ..note = fields[8] as String;
  }

  @override
  void write(BinaryWriter writer, RecurringRule obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.isExpense)
      ..writeByte(5)
      ..write(obj.frequency)
      ..writeByte(6)
      ..write(obj.nextDueDate)
      ..writeByte(7)
      ..write(obj.isActive)
      ..writeByte(8)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecurringRuleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
