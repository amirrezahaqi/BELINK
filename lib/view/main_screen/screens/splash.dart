import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:new_started/controller/hive_controller/hive_category_controller.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/constants/routes/screens_routes.dart';
import 'package:new_started/gen/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final HiveCategoryController hiveCategoryController =
      Get.find<HiveCategoryController>();
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      hiveCategoryController.addDefaultCategoryToAPP();
      Get.offAndToNamed(ScreenRoutes.mainScreenRoute);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 100,
              ),
              Assets.images.beelink.image(width: 200),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 20,
              ),
              SpinKitWaveSpinner(
                color: Get.isDarkMode
                    ? SolidColors.scaffoldColor
                    : SolidColors.darkModeItemColor,
                size: 30,
              ),
            ]),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Version 0.0", style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
