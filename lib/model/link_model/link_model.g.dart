// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LinkModelAdapter extends TypeAdapter<LinkModel> {
  @override
  final int typeId = 3;

  @override
  LinkModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LinkModel()
      ..name = fields[0] as String
      ..link = fields[1] as String
      ..domain = fields[2] as String
      ..htmlTag = fields[3] as String
      ..readReminderTime = fields[4] as DateTime
      ..isBookMark = fields[5] as bool
      ..isPrivate = fields[6] as bool
      ..category = fields[7] as CategoryModel?
      ..tag = fields[8] as TagModel;
  }

  @override
  void write(BinaryWriter writer, LinkModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.link)
      ..writeByte(2)
      ..write(obj.domain)
      ..writeByte(3)
      ..write(obj.htmlTag)
      ..writeByte(4)
      ..write(obj.readReminderTime)
      ..writeByte(5)
      ..write(obj.isBookMark)
      ..writeByte(6)
      ..write(obj.isPrivate)
      ..writeByte(7)
      ..write(obj.category)
      ..writeByte(8)
      ..write(obj.tag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LinkModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
