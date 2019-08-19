import 'package:flutter/widgets.dart';
import 'package:tgg/ui/tabs/home_tab.dart';
import 'package:tgg/ui/tabs/stub_tab.dart';

class RouteTabMapper {
  static Widget map(String name) {
    switch (name) {
      case 'home':
        return HomeTab();
      default:
        return StubTab(title: name);
    }
  }
}
