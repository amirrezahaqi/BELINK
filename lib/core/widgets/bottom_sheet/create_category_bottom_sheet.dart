import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_started/controller/hive_controller/hive_category_controller.dart';
import 'package:new_started/core/constants/Texts/text_constant.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/constants/dimens/dimens.dart';
import 'package:new_started/core/widgets/app_bottom/app_bottom_widget.dart';
import 'package:new_started/core/widgets/app_bottom/color_picker_bottom.dart';
import 'package:new_started/model/category_model/category_model.dart';

import '../app_text_field/app_text_field.dart';
import '../color_picker/color_picker_custom_dialog.dart';

Future<dynamic> createCategoryBottomSheet(BuildContext context) {
  final HiveCategoryController hiveCategoryController =
      Get.find<HiveCategoryController>();
  final Size size = MediaQuery.of(context).size;
  final ThemeData themeData = Theme.of(context);
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    builder: (context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: size.height / 1.2,
          padding: const EdgeInsets.all(Dimens.small),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(height: Dimens.medium),
              //search text field
              LinkeryTextField(
                controller: hiveCategoryController.categorySearchTextController,
                width: 300,
                hintText: AppTextConstants.nameTxt,
              ),
              // icon list
              Obx(
                () => Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(Dimens.medium + 4),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                    ),
                    // در صورتی که متنی داخل سرچ باکس نباشه کل ایتم ها رو نمایش میده و در صورت سرچ کل ایتم ها رو
                    itemCount: hiveCategoryController
                            .categorySearchTextController.text.isEmpty
                        ? hiveCategoryController.categoryDefaultList.length
                        : hiveCategoryController.categoryDefaultList
                            .where((element) => element.name.contains(
                                hiveCategoryController
                                    .categorySearchTextController.text
                                    .toLowerCase()))
                            .length,
                    itemBuilder: (context, index) {
                      CategoryModel item;
                      if (hiveCategoryController
                          .categorySearchTextController.text.isEmpty) {
                        item =
                            hiveCategoryController.categoryDefaultList[index];
                      } else {
                        item = hiveCategoryController.categoryDefaultList
                            .where((element) => element.name.contains(
                                hiveCategoryController
                                    .categorySearchTextController.text
                                    .toLowerCase()))
                            .toList()[index];
                      }
                      // category item
                      return GestureDetector(
                        onTap: () {
                          hiveCategoryController
                              .categoryNameTextController.text = item.name.tr;
                          hiveCategoryController.currentIcon.value = item.icon;
                        },
                        child: SvgPicture.asset(
                          item.icon,
                          // ignore: deprecated_member_use
                          color: themeData.iconTheme.color,
                          height: Dimens.small,
                          width: Dimens.small,
                          fit: BoxFit.scaleDown,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: Dimens.medium),
              // color picker
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(
                    () {
                      return LinkeryTextField(
                        controller:
                            hiveCategoryController.categoryNameTextController,
                        prefixIcon: SvgPicture.asset(
                            hiveCategoryController.currentIcon.value,
                            height: 12,
                            width: 12,
                            fit: BoxFit.scaleDown,
                            colorFilter: ColorFilter.mode(
                                hiveCategoryController.iconColor.value,
                                BlendMode.srcIn)),
                        width: 260,
                        hintText: AppTextConstants.nameTxt.tr,
                      );
                    },
                  ),
                  // change color btn
                  ColorPickerBottom(
                    onTap: () {
                      linkeryColorPicker(
                          context: context,
                          pickerColor: SolidColors.redColor,
                          onChange: (newColor) => hiveCategoryController
                              .iconColor.value = newColor);
                    },
                  )
                ],
              ),
              const SizedBox(height: Dimens.large),
              LinkeryBottom(
                text: AppTextConstants.save.tr,
                onPress: () => hiveCategoryController.addCategory(context),
              )
            ],
          ),
        ),
      );
    },
  );
}
