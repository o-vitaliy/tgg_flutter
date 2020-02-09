import 'package:flutter/material.dart';
import 'package:tgg/common/flavor/flavor.dart';

Widget createSuccessDialog(int attempts, Flavor flavor, Function onPressed) =>
    _createDialog(
      attempts: attempts,
      flavor: flavor,
      onPressed: onPressed,
      textTemplate: missionCorrectText,
      imageTemplate: missionCorrectImage,
    );

Widget createErrorDialog(
        String answer, int attempts, Flavor flavor, Function onPressed) =>
    _createDialog(
        attempts: attempts,
        flavor: flavor,
        onPressed: onPressed,
        textTemplate: tryAgainText,
        imageTemplate: tryAgainImage,
        textTemplateParams: {"given": answer});

Widget _createDialog(
        {int attempts,
        Flavor flavor,
        Function onPressed,
        String textTemplate,
        String imageTemplate,
        Map<String, dynamic> textTemplateParams}) =>
    AlertDialog(
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Image.network(flavor.iterable(imageTemplate, attempts)),
        Text(flavor.iterable(textTemplate, attempts,
            params: textTemplateParams)),
      ]),
      actions: [
        RaisedButton(
          child: Text(flavor.get(messageOk)),
          onPressed: onPressed,
        )
      ],
    );
