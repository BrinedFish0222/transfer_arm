// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonEntity _$CommonEntityFromJson(Map<String, dynamic> json) => CommonEntity(
      id: json['id'] as int?,
    );

Map<String, dynamic> _$CommonEntityToJson(CommonEntity instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  return val;
}
