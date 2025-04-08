// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuizHistoryAdapter extends TypeAdapter<QuizHistory> {
  @override
  final int typeId = 29;

  @override
  QuizHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuizHistory(
      quiz: fields[0] as String,
      totalQuestions: fields[1] as int,
      answer1: fields[2] as String,
      answer2: fields[3] as String,
      answer3: fields[4] as String,
      answer4: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, QuizHistory obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.quiz)
      ..writeByte(1)
      ..write(obj.totalQuestions)
      ..writeByte(2)
      ..write(obj.answer1)
      ..writeByte(3)
      ..write(obj.answer2)
      ..writeByte(4)
      ..write(obj.answer3)
      ..writeByte(5)
      ..write(obj.answer4);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
