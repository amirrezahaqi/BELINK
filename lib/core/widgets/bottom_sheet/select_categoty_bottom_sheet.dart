import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:new_started/controller/hive_controller/hive_category_controller.dart';
import 'package:new_started/controller/hive_controller/hive_link_controller.dart';
import 'package:new_started/core/constants/Texts/text_constant.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/constants/dimens/dimens.dart';
import 'package:new_started/core/constants/text_style/text_styles.dart';
import 'package:new_started/core/widgets/app_bottom/app_bottom_widget.dart';
import 'package:new_started/core/widgets/main_item/app_main_item.dart';
import 'package:new_started/gen/assets.gen.dart';
import 'package:new_started/model/category_model/category_model.dart';

import 'create_category_bottom_sheet.dart';

Future<dynamic> selectCategoryBottomSheet(BuildContext context, bool onlyShow) {
  // controller
  final HiveCategoryController hiveCategoryController =
      Get.find<HiveCategoryController>();
  final HiveLinkController hiveLinkController = Get.find<HiveLinkController>();

  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(24),
      topRight: Radius.circular(24),
    )),
    builder: (context) {
      final Size size = MediaQuery.of(context).size;
      return Padding(
        padding: EdgeInsets.only(
            left: Dimens.medium,
            right: Dimens.medium,
            top: Dimens.large,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            //category list
            ValueListenableBuilder(
              valueListenable: hiveCategoryController.categoryBox.listenable(),
              builder: (context, box, child) {
                final data = box.values.toList();
                return Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(Dimens.medium + 4),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 12),
                    itemCount: data.length + 1,
                    itemBuilder: (context, index) {
                      // ایتم اضافه کردن دسته بندی جدید
                      if (index == 0) {
                        return MainAppItem(
                          width: size.width / 4,
                          height: size.height / 8,
                          blurRadius: 5,
                          iconHeight: 32,
                          shadowOpacity: 0.20,
                          shadowYOffset: 5,
                          iconPath: Assets.icon.plus,
                          iconColor: SolidColors.grayColor,
                          text: 'Add new'.tr,
                          textStyle: AppTextStyle.articleContentTextStyle
                              .copyWith(fontSize: 10),
                          onTap: () => createCategoryBottomSheet(context),
                        );
                      }
                      // ایتم های دسته بندی
                      else {
                        final item = data[index - 1];
                        return Obx(
                          () => Stack(
                            children: [
                              // ایتم دسته بندی
                              MainAppItem(
                                width: size.width / 4,
                                height: size.height / 8,
                                blurRadius: 5,
                                shadowOpacity: 0.20,
                                iconHeight: 32,
                                iconPath: item.icon,
                                iconColor: item.color,
                                text: item.name,
                                textStyle: AppTextStyle.articleContentTextStyle
                                    .copyWith(fontSize: 10),
                                onTap: () {
                                  if (!onlyShow) {
                                    hiveLinkController.categoryModel = item;
                                    hiveCategoryController
                                        .selectedCategory.value = item;
                                  }
                                },
                              ),

                              if (hiveCategoryController
                                      .selectedCategory.value ==
                                  item)
                                const Positioned(
                                    right: 0,
                                    child: Icon(Icons.check,
                                        color: SolidColors.greenColor))
                            ],
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.01),
            LinkeryBottom(
              text: AppTextConstants.save,
              onPress: () {
                if (!onlyShow) {
                  hiveLinkController.addLinkToDataBase(context);
                  hiveCategoryController.selectedCategory.value =
                      CategoryModel();
                  Get.back();
                } else {
                  Get.back();
                }
              },
            ),
            SizedBox(height: size.height * 0.01),
          ],
        ),
      );
    },
  );
}
