import 'package:flutter/material.dart';
import 'package:tgg/common/flavor/flavor.dart';

Widget buildTeamWidget({
  Flavor flavor,
  String text,
  String teamName,
  String buttonTitle,
  Function click,
  String buttonTitle2,
  Function click2,
}) {
  return Container(
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(4)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(flavor.get(text, params: {"teamName": teamName})),
          ),
          RaisedButton(
            child: Text(flavor.get(buttonTitle)),
            onPressed: click,
          )
        ]..addAll(buttonTitle2 != null
            ? [
                SizedBox(width: 8, height: 8),
                RaisedButton(
                  child: Text(flavor.get(buttonTitle2)),
                  onPressed: click2,
                )
              ]
            : []),
      ));
}
