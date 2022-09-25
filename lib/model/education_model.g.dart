// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EducationModelAdapter extends TypeAdapter<EducationModel> {
  @override
  final int typeId = 0;

  @override
  EducationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EducationModel()
      ..educationTypeCTR = fields[0] as String
      ..educationYearCTR = fields[1] as String
      ..instituteNameCTR = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, EducationModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.educationTypeCTR)
      ..writeByte(1)
      ..write(obj.educationYearCTR)
      ..writeByte(2)
      ..write(obj.instituteNameCTR);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EducationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
