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
/*

class HomeToolbarState extends State<HomeToolbar> {
  final TabItemClickCallback _tabItemClickCallback;
  final RouteMode _selected;

  HomeToolbarState(this._tabItemClickCallback, this._selected);

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.routing,
      builder: (context, AsyncSnapshot<Routing> snapshot) {
        if (snapshot.hasData) {
          return buildPage(snapshot.data);
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget buildPage() {
   
  }
Widget buildPage(Routing routing) {
    return Container(
        height: 56.0,
        alignment: Alignment.center,
        decoration: new BoxDecoration(
            border: new Border(bottom: BorderSide(color: Color(0xFFCCCCCCC)))),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: routing.modes.length,
            itemBuilder: (context, index) => Container(
                width: 56,
                height: 56,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      IconMapper.map(routing.modes[index].icon),
                      size: 22,
                      color: Colors.green,
                    ),
                    Text(
                      routing.modes[index].title,
                      style: new TextStyle(
                        fontSize: 12.0,
                        color: Colors.green,
                      ),
                    )
                  ],
                ))));
  }
}
*/
