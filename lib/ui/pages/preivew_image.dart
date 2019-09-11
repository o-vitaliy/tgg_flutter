import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tgg/ui/pages/navigation_arguments.dart';

class PreviewImage extends StatelessWidget {
  static const routeName = '/previewImage';

  @override
  Widget build(BuildContext context) {
    final ImagePreviewArguments args =
        ModalRoute.of(context).settings.arguments;
    return Image.file(File(args.imagePath));
  }
}
