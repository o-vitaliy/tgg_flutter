import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tgg/models/modes.dart';
import 'package:tgg/ui/helpers/icon_mapper.dart';
import 'package:tgg/ui/home.dart';

class CollapsibleTabBar extends StatelessWidget {
  CollapsibleTabBar(
    this.children,
    this.selected, {
    this.maxItemsInRow = 5,
  });

  final List<CollapsibleTabBarItemData> children;
  final RouteMode selected;

  final int maxItemsInRow;
  final GlobalKey _moreKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final rowsCount = children.length > maxItemsInRow ? 2 : 1;

    int indexOfSelected = min(
        children.indexWhere((it) => it.data == selected), maxItemsInRow - 1);

    final childList = List<CollapsibleTabBarItemData>();
    if (rowsCount == 1) {
      childList.addAll(children);
    } else {
      childList.addAll(children.sublist(0, maxItemsInRow - 1));
      childList.add(createMoreItem());
    }
    PopupMenuButton button = PopupMenuButton(
        key: _moreKey,
        itemBuilder: (_) => _getMenuItems(),
        onSelected: (it) {
          it.clickCallback(it.data);
        });

    int index = 0;
    final items = childList
        .map((data) => _CollapsibleTabBarItem(
              icon: data.icon,
              data: data.data,
              title: data.title,
              clickCallback: data.clickCallback,
              selected: index++ == indexOfSelected,
              enabled: data.enabled,
            ))
        .toList();
    return Stack(children: <Widget>[
      Container(
          width: double.infinity,
          child: Row(mainAxisSize: MainAxisSize.max, children: items)),
      Padding(
          padding: EdgeInsets.only(top: 56),
          child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 0,
                height: 0,
                child: button,
              ))),
    ]);
  }

  CollapsibleTabBarItemData createMoreItem() => CollapsibleTabBarItemData(
      icon: BARS, clickCallback: showMore, data: RouteMode.menu());

  void showMore(data) {
    dynamic state = _moreKey.currentState;
    state.showButtonMenu();
  }

  List<PopupMenuItem<CollapsibleTabBarItemData>> _getMenuItems() {
    return children
        .sublist(maxItemsInRow - 1, children.length)
        .map((data) => PopupMenuItem<CollapsibleTabBarItemData>(
            enabled: data.enabled,
            child: Row(
              children: <Widget>[
                Icon(IconMapper.map(data.icon)),
                Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      data.title,
                    ))
              ],
            ),
            value: data))
        .toList();
  }
}

class CollapsibleTabBarItemData {
  final data;
  final String icon;
  final String title;
  final TabItemClickCallback clickCallback;
  final bool enabled;

  CollapsibleTabBarItemData({
    this.data,
    this.title,
    this.icon,
    this.clickCallback,
    this.enabled = true,
  });
}

class _CollapsibleTabBarItem extends StatelessWidget {
  final data;
  final String icon;
  final String title;
  final TabItemClickCallback clickCallback;
  final bool selected;
  final bool enabled;

  const _CollapsibleTabBarItem(
      {Key key,
      this.icon,
      this.data,
      this.clickCallback,
      this.selected,
      this.title,
      this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Material(
            color: Color.fromARGB(0, 0, 0, 0),
            child: InkWell(
                onTap: enabled ? () => clickCallback(data) : null,
                child: Container(
                  color: enabled
                      ? (selected
                          ? Theme.of(context).primaryColorDark
                          : Theme.of(context).primaryColor)
                      : Theme.of(context).disabledColor,
                  height: 56,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(
                        IconMapper.map(icon),
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: title != null
                            ? Text(
                                title,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              )
                            : SizedBox.shrink(),
                      )
                    ],
                  ),
                ))));
  }
}
