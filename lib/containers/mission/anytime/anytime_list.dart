import 'package:flutter/material.dart';
import 'package:tgg/models/mission.dart';

class AnytimeList extends StatelessWidget {
  final List<Mission> missions;
  final Function(Mission) onSelect;

  const AnytimeList({Key key, this.missions, this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: missions
            .map((m) => RaisedButton(
                  child: Text(m.name),
                  onPressed: () => onSelect(m),
                ))
            .toList());
  }
}
