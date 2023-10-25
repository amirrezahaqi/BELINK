import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_started/controller/navigation_controller/bottom_navigation_controller.dart';
import 'package:new_started/core/constants/eums/link_page_state.dart';
import 'package:new_started/core/widgets/bottom_navigation/bottom_navigation_widget.dart';
import 'package:new_started/view/home_screen/screens/home_screen.dart';
import 'package:new_started/view/link_screen/screens/all_link_screen.dart';
import 'package:new_started/view/setting_screen/screens/setting_screens.dart';

import '../../web_view_screen/screens/last_read_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final BottomNavigationController navigationController =
        Get.find<BottomNavigationController>();
    return Obx(
      () {
        return Scaffold(
            bottomNavigationBar: LinkeryBottomNavigation(
              onTapChange: (index) {
                //navigationController.history.remove(navigationController.currentIndex.value);
                //navigationController.history.add(navigationController.currentIndex.value);
                navigationController.currentIndex.value = index;
              },
            ),
            body: IndexedStack(
              index: navigationController.currentIndex.value,
              children: [
                // Navigator(key: navigationController.homeKey,onGenerateRoute: (settings) => MaterialPageRoute(builder: (context) => const HomeScreen())),
                // Navigator(key: navigationController.singleArticleKey,onGenerateRoute: (settings) => MaterialPageRoute(builder: (context) => const SingleArticleScreen())),
                // Navigator(key: navigationController.allLinkKey,onGenerateRoute: (settings) => MaterialPageRoute(builder: (context) => AllLinkScreen(linkPageState: LinkPageState.bookMark))),
                // Navigator(key: navigationController.settingKey,onGenerateRoute: (settings) => MaterialPageRoute(builder: (context) => const SettingScreen())),
                const HomeScreen(),
                const LastReadScreen(),
                AllLinkScreen(linkPageState: LinkPageState.bookMark),
                const SettingScreen()
              ],
            ));
      },
    );
  }
}
