import 'package:hive_flutter/adapters.dart';
part 'tag_model.g.dart';

@HiveType(typeId: 1)
class TagModel extends HiveObject {
  @HiveField(0)
  String title = '';

  TagModel();

  TagModel.fromJson(Map<String,dynamic> json){
    title = json['title'];
  }

  Map<String,dynamic> toJson() => {
    'title' : title
  };
}