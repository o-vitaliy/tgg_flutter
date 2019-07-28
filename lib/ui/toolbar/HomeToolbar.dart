import 'package:flutter/material.dart';
import 'package:tgg/blocs/blueprint_bloc.dart';
import 'package:tgg/models/routing.dart';
import 'package:tgg/ui/helpers/icon_mapper.dart';

class HomeToolbar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeToolbarState();
  }
}

class HomeToolbarState extends State<HomeToolbar> {
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
