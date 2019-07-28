import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconMapper {
  static IconData map(String name) {
    switch (name) {
      case 'icon-group':
        return FontAwesomeIcons.users;
      case 'icon-screenshot':
        return FontAwesomeIcons.crosshairs;
      case 'icon-camera':
        return FontAwesomeIcons.camera;
      default:
        return FontAwesomeIcons.question;
    }
  }
}
