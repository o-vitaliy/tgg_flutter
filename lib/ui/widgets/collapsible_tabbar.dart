import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tgg/models/modes.dart';
import 'package:tgg/ui/helpers/icon_mapper.dart';
import 'package:tgg/ui/home.dart';

class CollapsibleTabBar extends StatelessWidget {
  CollapsibleTabBar(this.children, this.selected,
      {this.maxItemsInRaw = 4, this.maxItemsInRow});

  final int maxItemsInRow;
  final List<CollapsibleTabBarItemData> children;
  final RouteMode selected;

  final int maxItemsInRaw;
  final GlobalKey _moreKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final rowsCount = children.length > maxItemsInRaw ? 2 : 1;

    final childList = List<CollapsibleTabBarItemData>();
    if (rowsCount == 1) {
      childList.addAll(children);
    } else {
      childList.addAll(children.sublist(0, maxItemsInRaw - 1));
      childList.add(createMoreItem());
    }
    PopupMenuButton button = new PopupMenuButton(
        key: _moreKey, itemBuilder: (_) => _getMenuItems(), onSelected: (_) {});

    final items = childList
        .map((data) => _CollapsibleTabBarItem(
            icon: data.icon,
            data: data.data,
            clickCallback: data.clickCallback,
            selected: data.data == selected))
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

  CollapsibleTabBarItemData createMoreItem() =>
      CollapsibleTabBarItemData(icon: BARS, clickCallback: showMore);

  void showMore(data) {
    dynamic state = _moreKey.currentState;
    state.showButtonMenu();
  }

  List<PopupMenuItem<CollapsibleTabBarItemData>> _getMenuItems() {
    return children
        .sublist(maxItemsInRaw - 1, children.length)
        .map((data) => PopupMenuItem<CollapsibleTabBarItemData>(
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

  CollapsibleTabBarItemData(
      {this.data, this.title, this.icon, this.clickCallback});
}

class _CollapsibleTabBarItem extends StatelessWidget {
  final data;
  final String icon;
  final String title;
  final TabItemClickCallback clickCallback;
  final bool selected;

  const _CollapsibleTabBarItem(
      {Key key,
      this.icon,
      this.data,
      this.clickCallback,
      this.selected,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Material(
            color: Color.fromARGB(0, 0, 0, 0),
            child: InkWell(
                onTap: () => clickCallback(data),
                child: Container(
                  color: selected
                      ? Theme.of(context).primaryColorDark
                      : Theme.of(context).primaryColor,
                  height: 56,
                  child: Icon(IconMapper.map(icon)),
                ))));
  }
}
