// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logs_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LogsModelAdapter extends TypeAdapter<LogsModel> {
  @override
  final int typeId = 2;

  @override
  LogsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LogsModel(
      logDate: fields[0] as DateTime?,
      bloodFlow: fields[1] as num?,
      moods: fields[3] as String?,
      symptoms: fields[2] as String?,
      notes: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LogsModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.logDate)
      ..writeByte(1)
      ..write(obj.bloodFlow)
      ..writeByte(2)
      ..write(obj.symptoms)
      ..writeByte(3)
      ..write(obj.moods)
      ..writeByte(4)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
