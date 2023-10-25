import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:new_started/controller/hive_controller/hive_link_controller.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/constants/dimens/dimens.dart';
import 'package:new_started/core/constants/texts/text_constant.dart';
import 'package:new_started/core/widgets/app_bottom/app_bottom_widget.dart';
import 'package:new_started/core/widgets/app_text_field/app_text_field.dart';

import '../../../view/web_view_screen/widgets/tag_widget/article_tag_widget.dart';

Future<dynamic> createNewLinkBottomSheet(BuildContext context) {
  final HiveLinkController hiveLinkController = Get.find<HiveLinkController>();
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
      final Size size = MediaQuery.of(context).size;
      return Padding(
        padding: EdgeInsets.only(
            top: Dimens.medium,
            left: Dimens.medium,
            right: Dimens.medium,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: 450,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(height: 12),
              //name text field
              LinkeryTextField(
                controller: hiveLinkController.linkNameTextController,
                width: 300,
                hintText: AppTextConstants.nameTxt,
              ),
              // icon list
              LinkeryTextField(
                controller: hiveLinkController.linkTextController,
                suffixIcon: IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () => hiveLinkController.pasteLinkToField()),
                width: 300,
                hintText: AppTextConstants.linkTxt,
              ),

              LinkeryTextField(
                controller: hiveLinkController.linkTagTextController,
                width: 300,
                hintText: AppTextConstants.tagTxt,
              ),
              // tag list
              ValueListenableBuilder(
                valueListenable: hiveLinkController.tagBox.listenable(),
                builder: (context, box, child) {
                  final data = box.values.toList();
                  return SizedBox(
                    height: size.height / 24,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final item = data[index];
                        return Padding(
                          padding: EdgeInsets.only(
                              left: index == 0 ? Dimens.large : Dimens.medium),
                          child: TagItem(
                              onTap: () => hiveLinkController
                                  .linkTagTextController.text = item.title,
                              width: size.width * 0.18,
                              text: item.title),
                        );
                      },
                    ),
                  );
                },
              ),

              Obx(() {
                return CheckboxListTile(
                  title: Text(AppTextConstants.private.tr),
                  checkColor: SolidColors.redColor,
                  activeColor: SolidColors.blackColor,
                  onChanged: (newValue) =>
                      hiveLinkController.isPrivate.value = newValue!,
                  controlAffinity: ListTileControlAffinity.leading,
                  value: hiveLinkController
                      .isPrivate.value, //  <-- leading Checkbox
                );
              }),

              LinkeryBottom(
                text: AppTextConstants.nextTxt,
                onPress: () => hiveLinkController.checkValidateData(context),
              )
            ],
          ),
        ),
      );
    },
  );
}
