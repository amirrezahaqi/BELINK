import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';

import '../../gen/assets.gen.dart';

part 'category_model.g.dart';

@HiveType(typeId: 2)
class CategoryModel extends HiveObject {
  @HiveField(0)
  String name = '';
  @HiveField(1)
  String icon = Assets.icon.lock;
  @HiveField(2)
  Color color = SolidColors.redColor;

  CategoryModel(
      {this.name = '', this.icon = '', this.color = SolidColors.blackColor});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() => {'name': name, 'icon': icon, 'color': color};
}
