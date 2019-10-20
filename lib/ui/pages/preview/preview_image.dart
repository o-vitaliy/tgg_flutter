import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tgg/bloc/aws_upload/bloc.dart';
import 'package:tgg/ui/pages/preview/preview.dart';
import 'package:tgg/ui/widgets/text_button.dart';

class ImagePreview extends StatelessWidget {
  final String imageLink;

  const ImagePreview({Key key, @required this.imageLink})
      : assert(imageLink != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(child: Image.file(File(imageLink))),
        buildPreviewControls()
      ],
    );
  }

  Widget buildPreviewControls() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox.fromSize(
          size: Size.fromHeight(rowHeight),
          child: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              Container(
                height: 48,
                color: defaultBackground,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    text: "Back",
                    onTap: (context) => Navigator.pop(context),
                  )),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    text: "Submit",
                    onTap: (context) {
                      BlocProvider.of<AwsUploadBloc>(context)
                          .dispatch(StartAwsUploadEvent(imageLink));
                      Navigator.pop(context);
                    },
                  )),
            ],
          )),
    );
  }
}
