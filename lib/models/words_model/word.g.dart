// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordsAdapter extends TypeAdapter<Words> {
  @override
  final int typeId = 0;

  @override
  Words read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Words(
      id: fields[0] as int?,
      nameEn: fields[1] as String?,
      nameUz: fields[2] as String?,
      isSelected: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Words obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nameEn)
      ..writeByte(2)
      ..write(obj.nameUz)
      ..writeByte(3)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
