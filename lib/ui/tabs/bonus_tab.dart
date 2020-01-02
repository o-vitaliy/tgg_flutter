import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tgg/ui/widgets/bonus_camera_builder.dart';

class BonusTab extends StatelessWidget {
  BonusTab({Key key}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      widthFactor: 0.8,
      child: BonusCameraBuilder(
          buttonBuilder: (context, onPressed) =>
              RaisedButton(
                onPressed: onPressed,
                child: Text(
                  "Bonus camera",
                ),
                textColor: Colors.white,
              )),
    );
  }
}
