import 'package:flutter/material.dart';
import 'package:tgg/models/mission.dart';
import 'package:tgg/common/theme/themed_buttons.dart';

class AnytimeList extends StatelessWidget {
  final List<Mission> missions;
  final Function(Mission) onSelect;

  const AnytimeList({Key key, this.missions, this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: missions
            .map((m) =>
                getMainTextButton(label: m.name, onPressed: () => onSelect(m)))
            .toList());
  }
}
