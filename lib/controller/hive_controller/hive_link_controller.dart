import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:new_started/controller/notification_controller/notification_controller.dart';
import 'package:new_started/core/constants/Texts/text_constant.dart';
import 'package:new_started/core/constants/app_keys/hive_keys.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/widgets/bottom_sheet/create_newlink_bottom_sheet.dart';
import 'package:new_started/core/widgets/bottom_sheet/select_categoty_bottom_sheet.dart';
import 'package:new_started/core/widgets/snackbar_widget/custom_snackbar_widget.dart';
import 'package:new_started/model/category_model/category_model.dart';
import 'package:new_started/model/link_model/link_model.dart';
import 'package:new_started/model/tag_model/tag_model.dart';
import 'package:share_plus/share_plus.dart';

class HiveLinkController extends GetxController {
  final linkBox = Hive.box<LinkModel>(HiveKeys.linkKey);
  final tagBox = Hive.box<TagModel>(HiveKeys.tagKey);

  final TextEditingController linkNameTextController = TextEditingController();
  final TextEditingController linkTextController = TextEditingController();
  final TextEditingController linkTagTextController = TextEditingController();
  RxBool isPrivate = false.obs;

  LinkModel linkModel = LinkModel();
  LinkModel? existingLink;
  TagModel? existingTag;
  CategoryModel categoryModel = CategoryModel();

  //در صورتی که تگ وجود داشته باشه فقط مقدار دهی همیشه و اگر وجود نداشته باشه به دیتا بیس اضافه و بعد مقدار دهی میشه
  initialLinkTag() {
    TagModel tagModel = TagModel();
    tagModel.title = linkTagTextController.text;
    existingTag = tagBox.values.firstWhere((tag) => tag.title == tagModel.title,
        orElse: () => tagModel);
    if (existingTag!.isInBox) {
      linkModel.tag = existingTag!;
    } else {
      tagBox.add(tagModel);
      linkModel.tag = tagModel;
    }
  }

  checkValidateData(BuildContext context) {
    final bool validateUrl = Uri.parse(linkTextController.text).host.isNotEmpty;
    if (linkTextController.text.isEmpty ||
        linkNameTextController.text.isEmpty ||
        linkTagTextController.text.isEmpty) {
      customSnackbar(
          title: AppTextConstants.error,
          massage: AppTextConstants.completedInformationLink,
          backgroundColor: SolidColors.redColor,
          textColor: SolidColors.scaffoldColor);
    } else if (!validateUrl) {
      customSnackbar(
          title: AppTextConstants.invalidLink,
          massage: AppTextConstants.invalidLinkMassage,
          backgroundColor: SolidColors.redColor,
          textColor: SolidColors.scaffoldColor,
          durationSeconds: 5);
    } else {
      Get.back();
      selectCategoryBottomSheet(context, false);
    }
  }

  // اضافه کردن لینک توسط کاربر
  addLinkToDataBase(BuildContext context) {
    if (categoryModel.name == "") {
      customSnackbar(
          title: AppTextConstants.error,
          massage: AppTextConstants.selectCategoryForLinkMsg,
          backgroundColor: SolidColors.redColor,
          textColor: SolidColors.scaffoldColor);
    } else {
      initialLinkTag(); // چک کردن و اضافه کردن تگ
      // مقدار دهی ویژگی های لینک
      if (existingLink != null) {
        initialForm(existingLink!);
        existingLink!.save();
      } else {
        initialForm(linkModel);
        linkBox.add(linkModel);
      }
      Get.back();
      clearForm();
    }
  }

  String getMainDomain() {
    Uri url = Uri.parse(linkTextController.text);
    String domain = url.host;
    return domain;
  }

  // اپدیت شدن لینک
  updateLink(BuildContext context, LinkModel link) {
    linkTextController.text = link.link;
    linkNameTextController.text = link.name;
    linkTagTextController.text = link.tag.title;
    categoryModel = link.category!;
    existingLink =
        linkBox.values.firstWhere((element) => element.name == link.name);
    Get.back();
    createNewLinkBottomSheet(context);
  }

  //حذف لینک
  deleteLink(LinkModel linkModel) => linkModel.delete();

  // حذف مقادیر داخل فرم ها
  clearForm() {
    linkNameTextController.clear();
    linkTextController.clear();
    linkTagTextController.clear();
    linkModel = LinkModel();
    existingLink = null;
    categoryModel = CategoryModel();
  }

  // مقدار دهی فرم ها برای ادد شدن یا اپدیت شدن
  initialForm(LinkModel linkModel) {
    linkModel.name = linkNameTextController.text;
    linkModel.link = linkTextController.text;
    linkModel.domain = getMainDomain(); // به دست اوردن دامنه اصلی لینک
    linkModel.isPrivate = isPrivate.value;
    linkModel.category = categoryModel;
    linkModel.tag = existingTag!;
  }

  // دریافت لینک کپی شده از گوشی کاربر و مقدار دهی فرم لینک
  pasteLinkToField() async {
    ClipboardData? copyData = await Clipboard.getData(Clipboard.kTextPlain);
    if (copyData != null) linkTextController.text = copyData.text!;
  }

  // به اشتراک گذاشتن لینک
  shareLink(LinkModel link) {
    Share.share("""
    ${AppTextConstants.titleTxt.tr} : ${link.name}
    ${AppTextConstants.linkTxt.tr} : ${link.link}
    ${AppTextConstants.category.tr} : ${link.category!.name}
    ${AppTextConstants.shareLinkText.tr}
    """);
  }

  // تنظیم یاد اور
  setReadReminder(
      {required BuildContext context,
      required String locale,
      required LinkModel link}) {
    final NotificationController notificationController =
        Get.find<NotificationController>();

    late final LocaleType localeType;
    // نمایش نوع تاریخ و ساعت بر اساس زبان انتخابی کاربر
    switch (locale) {
      case "fa":
        localeType = LocaleType.fa;
        break;
      case "en":
        localeType = LocaleType.en;
        break;
      case "ar":
        localeType = LocaleType.ar;
        break;
      case "ch":
        localeType = LocaleType.zh;
        break;
      default:
        {
          localeType = LocaleType.en;
        }
    }

    return DatePicker.showDateTimePicker(
      context,
      locale: localeType,
      currentTime: DateTime.now(),
      onConfirm: (time) {
        link.readReminderTime = time;
        notificationController.onTimeShowNotification(
            title: "وقتشه!!",
            body: """
              وقت دیدن این صفحس : ${link.name}
            لینک صفحه : ${link.link}
            """,
            sendTime: link.readReminderTime);
        link.save();
        Get.back();
      },
    );
  }
}
