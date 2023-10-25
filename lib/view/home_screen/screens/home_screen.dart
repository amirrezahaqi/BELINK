import 'package:flutter/material.dart';
import 'package:flutter_carousel_media_slider/carousel_media.dart';
import 'package:flutter_carousel_media_slider/flutter_carousel_media_slider.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:new_started/controller/hive_controller/hive_category_controller.dart';
import 'package:new_started/controller/hive_controller/hive_link_controller.dart';
import 'package:new_started/controller/notification_controller/notification_controller.dart';
import 'package:new_started/controller/translate/translate_controler.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/constants/dimens/dimens.dart';
import 'package:new_started/core/constants/eums/app_direction.dart';
import 'package:new_started/core/constants/routes/screens_routes.dart';
import 'package:new_started/core/constants/text_style/text_styles.dart';
import 'package:new_started/core/constants/texts/text_constant.dart';
import 'package:new_started/core/widgets/bottom_sheet/create_category_bottom_sheet.dart';
import 'package:new_started/core/widgets/bottom_sheet/create_newlink_bottom_sheet.dart';
import 'package:new_started/core/widgets/bottom_sheet/more_bottom_sheet.dart';
import 'package:new_started/core/widgets/bottom_sheet/select_categoty_bottom_sheet.dart';
import 'package:new_started/core/widgets/last_added_item/last_added_item_widget.dart';
import 'package:new_started/core/widgets/main_item/app_main_item.dart';
import 'package:new_started/gen/assets.gen.dart';
import 'package:new_started/view/home_screen/widgets/home_app_bar_widget.dart';
import 'package:new_started/view/home_screen/widgets/home_list_header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HiveCategoryController hiveCategoryController =
        Get.find<HiveCategoryController>();
    final HiveLinkController hiveLinkController =
        Get.find<HiveLinkController>();
    final TranslateController translateController =
        Get.find<TranslateController>();
    final NotificationController notificationController =
        Get.find<NotificationController>();

    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    return Scaffold(

        //اپ بار
        appBar: homeAppBar(
            size: size,
            bellTap: () {
              notificationController.showNotification(
                  id: 0, title: 'test', body: "this is test notif");
            }),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // poster
              Center(
                child: Container(
                  width: double.infinity,
                  height: size.height / 4.5,
                  margin: const EdgeInsets.all(Dimens.medium),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: FlutterCarouselMediaSlider(
                    carouselMediaList: media,
                    boxFit: BoxFit.cover,
                    placeholder: const Center(
                      child: Text('Loading...'),
                    ),
                    onPageChanged: (index) {
                      debugPrint('Page Changed: $index');
                    },
                  ),
                ),
              ),

              // Category title
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.medium, vertical: Dimens.small),
                child: HomeListHeader(
                    title: AppTextConstants.category,
                    viewAllOnTap: () {
                      selectCategoryBottomSheet(context, true);
                    }),
              ),

              // Category list
              SizedBox(
                height: size.height / 10,
                child: Row(
                  children: [
                    // add Category item
                    Padding(
                      padding: const EdgeInsets.all(Dimens.medium),
                      child: MainAppItem(
                        width: size.width / 6,
                        height: size.height / 9,
                        blurRadius: 5,
                        iconHeight: 32,
                        shadowOpacity: 0.30,
                        shadowYOffset: 7,
                        iconPath: Assets.icon.plus,
                        iconColor: SolidColors.grayColor,
                        text: AppTextConstants.addNew,
                        textStyle: AppTextStyle.articleContentTextStyle
                            .copyWith(fontSize: 10),
                        onTap: () => createCategoryBottomSheet(context),
                      ),
                    ),
                    //  Category list
                    HomeLinkCategories(
                        hiveCategoryController: hiveCategoryController,
                        size: size,
                        themeData: themeData,
                        translateController: translateController),
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // last added title
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.medium, vertical: Dimens.medium),
                child: HomeListHeader(
                    title: AppTextConstants.lastAdded,
                    viewAllOnTap: () {
                      Get.toNamed(ScreenRoutes.allLinkScreenRoute);
                    }),
              ),
              //آخرین لینک های اضافه شده
              ValueListenableBuilder(
                valueListenable: hiveLinkController.linkBox.listenable(),
                builder: (context, box, child) {
                  if (box.values.toList().isNotEmpty) {
                    final item = box.values.toList().last;
                    return LastAddedItem(
                      linkModel: item,
                      onMoreVertTap: () => moreBottomSheet(context, item),
                      onTap: () {
                        Get.toNamed(ScreenRoutes.showWebViewScreenRoute,
                            arguments: item);
                      },
                      shadowOpacity: 0.20,
                      blurRadius: 3,
                      height: size.height * 0.13,
                      size: size,
                    );
                  } else {
                    return Text(AppTextConstants.emptyNoBookMarkStateTxt.tr);
                  }
                },
              ),

              MainHomeToolsItems(size: size)
            ],
          ),
        ));
  }
}

//دسته بندی های اصلی صفحه اصلی

class HomeLinkCategories extends StatelessWidget {
  const HomeLinkCategories({
    super.key,
    required this.hiveCategoryController,
    required this.size,
    required this.themeData,
    required this.translateController,
  });

  final HiveCategoryController hiveCategoryController;
  final Size size;
  final ThemeData themeData;
  final TranslateController translateController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          //  Category list
          ValueListenableBuilder(
            valueListenable: hiveCategoryController.categoryBox.listenable(),
            builder: (context, box, child) {
              final data = box.values.toList();
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var item = data[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.small, vertical: Dimens.medium),
                    child: MainAppItem(
                      width: size.width / 6,
                      height: size.height / 9,
                      blurRadius: 5,
                      shadowOpacity: 0.30,
                      iconHeight: 32,
                      iconPath: item.icon,
                      iconColor: item.color,
                      text: item.name,
                      textStyle: AppTextStyle.articleContentTextStyle
                          .copyWith(fontSize: 10),
                      onTap: () {
                        Get.toNamed(ScreenRoutes.showCategoryLinksScreenRoute,
                            arguments: item);
                      },
                    ),
                  );
                },
              );
            },
          ),
          // gradiant
          Container(
            width: 20,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                  themeData.scaffoldBackgroundColor,
                  themeData.scaffoldBackgroundColor.withOpacity(0),
                ],
                    begin: translateController.directionality.value ==
                            AppDirection.ltr
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    end: translateController.directionality.value ==
                            AppDirection.ltr
                        ? Alignment.centerRight
                        : Alignment.centerLeft)),
          ),
        ],
      ),
    );
  }
}

//سه تا آیتم ابزار صفحه اصلی

class MainHomeToolsItems extends StatelessWidget {
  const MainHomeToolsItems({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.large),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // MainAppItem(
          //     borderRadius: 24,
          //     width: size.width / 3.5,
          //     height: size.width / 3.5,
          //     iconPath: './assets/icon/qrcode.svg',
          //     iconColor: SolidColors.darkGray,
          //     onTap: () {
          //       Navigator.of(context).push(MaterialPageRoute(
          //         builder: (context) => QrCodeScanner(),
          //       ));
          //     },
          //     blurRadius: 4,
          //     shadowOpacity: 0.30,
          //     shadowYOffset: 6,
          //     text: AppTextConstants.fromQrCode,
          //     textStyle: AppTextStyle.articleContentTextStyle),

          MainAppItem(
              borderRadius: 30,
              width: size.width / 2.5,
              height: size.width / 2.5,
              iconPath: './assets/icon/private link.svg',
              iconColor: SolidColors.darkGray,
              onTap: () => Get.toNamed(ScreenRoutes.privateLoginScreenRoute),
              blurRadius: 4,
              shadowOpacity: 0.30,
              shadowYOffset: 6,
              text: AppTextConstants.privateLinks,
              textStyle: AppTextStyle.articleContentTextStyle),
          MainAppItem(
              borderRadius: 30,
              width: size.width / 2.5,
              height: size.width / 2.5,
              iconPath: './assets/icon/plus.svg',
              iconColor: SolidColors.darkGray,
              onTap: () => createNewLinkBottomSheet(context),
              blurRadius: 4,
              shadowOpacity: 0.30,
              shadowYOffset: 6,
              text: AppTextConstants.addNew,
              textStyle: AppTextStyle.articleContentTextStyle),
        ],
      ),
    );
  }
}

List<CarouselMedia> media = [
  CarouselMedia(
    mediaName: 'Image 1',
    mediaUrl:
        "https://amirrezahaqi.ir/wp-content/uploads/2023/10/-scaled-1-e1698075734130.jpg",
    mediaType: CarouselMediaType.image,
    carouselImageSource: CarouselImageSource.network,
  ),
  CarouselMedia(
    mediaName: 'Image 2',
    mediaUrl:
        "https://amirrezahaqi.ir/wp-content/uploads/2023/10/-scaled-1-e1698075904947.jpg",
    mediaType: CarouselMediaType.image,
    carouselImageSource: CarouselImageSource.network,
  ),
];
