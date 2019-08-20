import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const BARS = "icon-bars";

class IconMapper {
  static IconData map(String name) {
    switch (name) {
      case 'icon-group':
        return FontAwesomeIcons.users;
      case 'icon-screenshot':
        return FontAwesomeIcons.crosshairs;
      case 'icon-camera':
        return FontAwesomeIcons.camera;
      case BARS:
        return FontAwesomeIcons.bars;
      default:
        return FontAwesomeIcons.question;
    }
  }
}
