import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationController extends GetxController{
  RxInt currentIndex = 0.obs;
  final List<int> history = [];

  // page index
  final int homeIndex = 0;
  final int articleIndex = 1;
  final int bookMarkIndex = 2;
  final int settingIndex = 3;

  //page Keys
  GlobalKey<NavigatorState> homeKey = GlobalKey();
  GlobalKey<NavigatorState> singleArticleKey = GlobalKey();
  GlobalKey<NavigatorState> allLinkKey = GlobalKey();
  GlobalKey<NavigatorState> settingKey = GlobalKey();

  Map<int,GlobalKey<NavigatorState>> get navigationMap => {
    homeIndex : homeKey,
    articleIndex : singleArticleKey,
    bookMarkIndex : allLinkKey,
    settingIndex : settingKey,
  };


  Future<bool> willPop() async {
    final currentNavigationTapState = navigationMap[currentIndex.value]!.currentState!;
    if (currentNavigationTapState.canPop()) {
      currentNavigationTapState.pop();
      return false;
    }else if(history.isNotEmpty){
      currentIndex.value = history.last;
      history.removeLast();
      return false;
    }
    return true;
  }

}