import 'package:flutter/material.dart';
import 'package:tgg/common/dialog/dialog_helper.dart';
import 'package:tgg/common/flavor/flavor.dart';

Future createSuccessDialog(int attempts, Flavor flavor) => showDialog(
    context: DialogHelper.findContext(),
    builder: (context) => _createDialog(
          context: context,
          attempts: attempts,
          flavor: flavor,
          textTemplate: missionCorrectText,
          imageTemplate: missionCorrectImage,
        ));

Future createErrorDialog(String answer, int attempts, Flavor flavor) =>
    showDialog(
        context: DialogHelper.findContext(),
        builder: (context) => _createDialog(
            context: context,
            attempts: attempts,
            flavor: flavor,
            textTemplate: tryAgainText,
            imageTemplate: tryAgainImage,
            textTemplateParams: {"given": answer}));

Widget _createDialog(
        {BuildContext context,
        int attempts,
        Flavor flavor,
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
        Text(flavor.iterable(textTemplate, attempts,
            params: textTemplateParams)),
      ]),
      actions: [
        RaisedButton(
          child: Text(flavor.get(messageOk)),
          onPressed: () => Navigator.pop(context),
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
