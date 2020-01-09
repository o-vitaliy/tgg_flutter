import 'package:flutter/material.dart';
import 'package:tgg/models/modes.dart';
import 'package:tgg/ui/widgets/collapsible_tabbar.dart';

class HomeToolbar extends StatelessWidget {
  final Function(RouteMode) _tabItemClickCallback;
  final RouteMode _selected;
  final List<RouteMode> _modes;

  const HomeToolbar(this._tabItemClickCallback, this._modes, this._selected,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = _modes
        .map((route) => CollapsibleTabBarItemData(
              data: route,
              title: route.title,
              icon: route.icon,
              clickCallback: _tabItemClickCallback,
            ))
        .toList()
          ..insert(0, CollapsibleTabBarItemData(
            title: "Home",
            icon: "home",
            clickCallback: _tabItemClickCallback,
          ));

    return CollapsibleTabBar(items, _selected);
  }
}
