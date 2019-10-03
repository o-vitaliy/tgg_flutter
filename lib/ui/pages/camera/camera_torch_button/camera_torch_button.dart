import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tgg/ui/widgets/base_square_icon_button.dart';

class CameraTorchButton extends StatelessWidget {
  final bool enabled;
  final TapCallback callback;

  const CameraTorchButton({Key key, this.enabled, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) => BaseSquareIconButton(
        icon: _getIcon(enabled),
        onTap: (context) => callback(context),
      );

  /// Returns a suitable camera icon for [direction].
  IconData _getIcon(bool enabled) {
    switch (enabled) {
      case true:
        return Icons.flash_on;
      case false:
        return Icons.flash_off;
    }
    throw ArgumentError('Unknown lens direction');
  }
}
