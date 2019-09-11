import 'package:flutter/material.dart';

import 'base_square_icon_button.dart';

class BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BaseSquareIconButton(
        icon: Icons.arrow_back,
        onTap: (context) => Navigator.pop(context),
      );
}
