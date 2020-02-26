import 'package:flutter/material.dart';
import 'package:tgg/common/flavor/flavor.dart';

const _messageOk = "message:ok";
const _confirm = "modes:head_to_head:confirm:";
const _received = "modes:head_to_head:confirm:received";
const _accept = "modes:head_to_head:actions:accept";
const _decline = "modes:head_to_head:actions:decline";

Widget createInvitedDialog(
    Flavor flavor, String result, String teamName, Function onPressed) {
  final key = _confirm + result;
  final title = flavor.get(key, params: {"teamName": teamName});
  return AlertDialog(
    content: Column(mainAxisSize: MainAxisSize.min, children: [
      Text(title),
    ]),
    actions: [
      RaisedButton(
        child: Text(flavor.get(_messageOk)),
        onPressed: onPressed,
      )
    ],
  );
}

Widget createReceivedInvitedDialog(
  Flavor flavor,
  String teamName,
  Function onAccept,
  Function onDecline,
) =>
    AlertDialog(
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(flavor.get(_received, params: {"teamName": teamName})),
      ]),
      actions: [
        RaisedButton(
          child: Text(flavor.get(_accept)),
          onPressed: onAccept,
        ),
        RaisedButton(
          child: Text(flavor.get(_decline)),
          onPressed: onDecline,
        )
      ],
    );

Widget createResultDialog(Flavor flavor, String message, Function onPressed) {
  final title = flavor.get(message);
  return AlertDialog(
    content: Column(mainAxisSize: MainAxisSize.min, children: [
      Text(title),
    ]),
    actions: [
      RaisedButton(
        child: Text(flavor.get(_messageOk)),
        onPressed: onPressed,
      )
    ],
  );
}
