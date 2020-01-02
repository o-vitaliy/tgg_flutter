import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HeadToHeadTab extends StatelessWidget {
  HeadToHeadTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        widthFactor: 0.8,
        child: RaisedButton(
          onPressed: () => null,
          child: Text(
            "Set default app theme (currently disabled)",
          ),
          textColor: Colors.white,
        ));
  }
}
