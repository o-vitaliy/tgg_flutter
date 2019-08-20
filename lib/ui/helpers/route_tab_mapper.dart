import 'package:flutter/widgets.dart';
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
      default:
        return StubTab(title: name);
    }
  }
}
