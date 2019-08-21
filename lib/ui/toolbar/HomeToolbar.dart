import 'package:flutter/material.dart';
import 'package:tgg/models/modes.dart';
import 'package:tgg/models/routing.dart';
import 'package:tgg/ui/home.dart';
import 'package:tgg/ui/widgets/collapsible_tabbar.dart';

class HomeToolbar extends StatelessWidget {
  final TabItemClickCallback _tabItemClickCallback;
  final RouteMode _selected;
  final Routing _routing;

  const HomeToolbar(this._tabItemClickCallback, this._routing, this._selected,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = _routing.modes
        .map((route) => CollapsibleTabBarItemData(
            data: route,
            title: route.title,
            icon: route.icon,
            clickCallback: (d) => _tabItemClickCallback(d)))
        .toList();

    return CollapsibleTabBar(items, _selected);
  }
}
