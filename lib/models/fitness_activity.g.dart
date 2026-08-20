// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fitness_activity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FitnessActivityAdapter extends TypeAdapter<FitnessActivity> {
  @override
  final int typeId = 0;

  @override
  FitnessActivity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FitnessActivity(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      exerciseType: fields[2] as String,
      workoutMinutes: fields[3] as int,
      steps: fields[4] as int,
      calories: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FitnessActivity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.exerciseType)
      ..writeByte(3)
      ..write(obj.workoutMinutes)
      ..writeByte(4)
      ..write(obj.steps)
      ..writeByte(5)
      ..write(obj.calories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FitnessActivityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
