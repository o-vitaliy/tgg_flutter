import 'package:flutter/widgets.dart';
import 'package:tgg/containers/waypoints/waypoints_container.dart';
import 'package:tgg/ui/routes.dart';
import 'package:tgg/ui/tabs/bonus_tab.dart';
import 'package:tgg/ui/tabs/head_to_head_tab.dart';
import 'package:tgg/ui/tabs/stub_tab.dart';

import '../keys.dart';

typedef TabBuilder = Widget Function(Key key);

class RouteTabMapper {
  final TabBuilder homeTabBuilder;

  RouteTabMapper({this.homeTabBuilder});

  Widget map(String name) {
    final key = Keys.homeTab(name);
    switch (name) {
      case 'home':
        return  homeTabBuilder(key) ;
      case 'main':
        return WaypointsContainer(key);
      case 'head_to_head':
        return HeadToHeadTab(key: key);
      case TAB_ROUTE_BONUS_CAMERA:
        return BonusTab(key: key);
      default:
        return StubTab(title: name, key: key);
    }
  }
}
