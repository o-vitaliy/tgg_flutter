import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../routes.dart';

class BonusTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
        widthFactor: 0.8,
        child: RaisedButton(
          onPressed: () => Navigator.pushNamed(context, ROUTE_BONUS_CAMERA),
          child: Text(
            "Bonus camera",
          ),
          textColor: Colors.white,
        ));
  }
}
