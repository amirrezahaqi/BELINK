// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:new_started/controller/hive_controller/hive_link_controller.dart';
import 'package:new_started/core/constants/Texts/text_constant.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/constants/dimens/dimens.dart';
import 'package:new_started/core/constants/text_style/text_styles.dart';
import 'package:new_started/core/widgets/bottom_sheet/create_newlink_bottom_sheet.dart';
import 'package:new_started/model/category_model/category_model.dart';
import 'package:new_started/model/link_model/link_model.dart';
import 'package:new_started/view/link_screen/widgets/empty_state.dart';
import 'package:new_started/view/link_screen/widgets/link_item_widget.dart';

class ShowCateGoryLinkScreen extends StatefulWidget {
  const ShowCateGoryLinkScreen({Key? key}) : super(key: key);

  @override
  State<ShowCateGoryLinkScreen> createState() => _ShowCateGoryLinkScreenState();
}

class _ShowCateGoryLinkScreenState extends State<ShowCateGoryLinkScreen> {
  late CategoryModel categoryModel;
  late String pageTitle;

  @override
  void initState() {
    super.initState();
    categoryModel = Get.arguments;
    pageTitle = "${categoryModel.name.tr}  ${AppTextConstants.linksTxt.tr}";
  }

  @override
  Widget build(BuildContext context) {
    final HiveLinkController hiveLinkController =
        Get.find<HiveLinkController>();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: hiveLinkController.linkBox.listenable(),
          builder: (context, box, child) {
            // لود شدن دیتا بر اساس نوع دسته بندی
            List<LinkModel> data = box.values
                .where(
                    (element) => element.category!.name == categoryModel.name)
                .toList();
            if (data.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Dimens.medium),
                    child: Text(pageTitle,
                        style: AppTextStyle.articleContentTextStyle.apply(
                            color: SolidColors.colorPrimary,
                            fontSizeFactor: 1.2)),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return LinkItem(
                            linkModel: data[index],
                            size: size,
                            verticalMargin: 10,
                            onTap: () => ()
                            // Get.toNamed(
                            //     ScreenRoutes.showWebViewScreenRoute,
                            //     arguments: data),
                            );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                  child: EmptyState(
                btnText: AppTextConstants.addNew,
                content: AppTextConstants.emptyCategoryStateTxt,
                onBtnTap: () => createNewLinkBottomSheet(context),
              ));
            }
          },
        ),
      ),
    );
  }
}
