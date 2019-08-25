import 'package:flutter/widgets.dart';
import 'package:tgg/ui/routes.dart';
import 'package:tgg/ui/tabs/bonus_tab.dart';
import 'package:tgg/ui/tabs/head_to_head_tab.dart';
import 'package:tgg/ui/tabs/stub_tab.dart';


typedef TabBuilder = Widget Function();

class RouteTabMapper {
  final TabBuilder homeTabBuilder;

  RouteTabMapper(this.homeTabBuilder);

  Widget map(String name) {
    print(name);
    switch (name) {
      case 'main':
        return homeTabBuilder();
      case 'head_to_head':
        return HeadToHeadTab();
      case TAB_ROUTE_BONUS_CAMERA:
        return BonusTab();
      default:
        return StubTab(title: name);
    }
  }
}
