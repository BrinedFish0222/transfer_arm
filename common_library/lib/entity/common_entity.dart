import 'package:json_annotation/json_annotation.dart';

part 'common_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class CommonEntity {

  int? id;


  CommonEntity({this.id});

  static List<CommonEntity> fromJsonList(List dataList) {
    return dataList.map((e) => CommonEntity.fromJson(e)).toList();
  }

  factory CommonEntity.fromJson(Map<String, dynamic> json) =>
      _$CommonEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CommonEntityToJson(this);
}
