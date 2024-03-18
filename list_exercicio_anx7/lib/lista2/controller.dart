import 'package:flutter/material.dart';

class TabControllerManager extends ChangeNotifier {
  final TabController tabController;

  TabControllerManager(this.tabController);

  void goToTab(int index) {
    tabController.animateTo(index);
    notifyListeners();
  }
}
