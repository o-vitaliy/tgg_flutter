import 'package:flutter/material.dart';
import 'package:tgg/common/flavor/flavor.dart';

Widget createSuccessDialog(
        String message, int attempts, Flavor flavor, Function onPressed) =>
    _createDialog(
      attempts: attempts,
      flavor: flavor,
      onPressed: onPressed,
      textTemplate: missionCorrectText,
      imageTemplate: missionCorrectImage,
    );

Widget createErrorDialog(String message, String answer, int attempts,
        Flavor flavor, Function onPressed) =>
    _createDialog(
        message: message,
        attempts: attempts,
        flavor: flavor,
        onPressed: onPressed,
        textTemplate: tryAgainText,
        imageTemplate: tryAgainImage,
        textTemplateParams: {"given": answer});

Widget _createDialog(
        {String message,
        int attempts,
        Flavor flavor,
        Function onPressed,
        String textTemplate,
        String imageTemplate,
        Map<String, dynamic> textTemplateParams}) =>
    AlertDialog(
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Image.network(
          flavor.iterable(imageTemplate, attempts),
          loadingBuilder: loadingBuilder,
          excludeFromSemantics: true,
        ),
        Text(message ??
            flavor.iterable(textTemplate, attempts,
                params: textTemplateParams)),
      ]),
      actions: [
        RaisedButton(
          child: Text(flavor.get(messageOk)),
          onPressed: onPressed,
        )
      ],
    );

final ImageLoadingBuilder loadingBuilder =
    (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
  if (loadingProgress == null) return child;
  return Center(
    child: CircularProgressIndicator(
      value: loadingProgress.expectedTotalBytes != null
          ? loadingProgress.cumulativeBytesLoaded /
              loadingProgress.expectedTotalBytes
          : null,
    ),
  );
};
