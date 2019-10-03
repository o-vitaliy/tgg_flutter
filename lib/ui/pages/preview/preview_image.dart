import 'dart:io';

import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  final String imageLink;

  const ImagePreview({Key key, @required this.imageLink})
      : assert(imageLink != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => Image.file(File(imageLink));
}
