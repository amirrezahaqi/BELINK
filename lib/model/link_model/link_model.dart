import 'package:hive/hive.dart';
import 'package:new_started/model/category_model/category_model.dart';
import 'package:new_started/model/tag_model/tag_model.dart';

part 'link_model.g.dart';

@HiveType(typeId: 3)
class LinkModel extends HiveObject {
  @HiveField(0)
  String name = '';
  @HiveField(1)
  String link = '';
  @HiveField(2)
  String domain = '';
  @HiveField(3)
  String htmlTag = '';
  @HiveField(4)
  DateTime readReminderTime = DateTime(0);
  @HiveField(5)
  bool isBookMark = false;
  @HiveField(6)
  bool isPrivate = false;
  @HiveField(7)
  CategoryModel? category = CategoryModel(name: '', icon: '');
  @HiveField(8)
  TagModel tag = TagModel();

  LinkModel();
  LinkModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    link = json['link'];
    domain = json['domain'];
    htmlTag = json['htmlTag'];
    readReminderTime = json['readReminderTime'];
    isBookMark = json['isBookMark'];
    isPrivate = json['isPrivate'];
    category = json['category'];
    tag = json['tag'];
  }
  Map<String, dynamic> toJson() => {
        'name': name,
        'link': link,
        'domain': domain,
        'htmlTag': htmlTag,
        'readReminderTime': readReminderTime,
        'isBookMark': isBookMark,
        'isPrivate': isPrivate,
        'category': category,
        'tag': tag,
      };

  void dispose() {}
}
