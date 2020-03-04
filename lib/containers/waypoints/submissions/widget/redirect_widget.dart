import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/common/theme/themed_buttons.dart';
import 'package:tgg/containers/login/login_actions.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';
import 'package:tgg/models/waypoints/submission_choice.dart';
import 'package:tgg/redux_model/app_state.dart';

class RedirectWidget extends StatelessValueWidget {
  final List<SubmissionChoice> choices;

  RedirectWidget(OnValueChange onValueChange, OnSubmit onSubmit,
      String initialValue, this.choices,
      {Key key})
      : super(onValueChange, onSubmit, initialValue, key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List<Widget>.of(choices.map((choice) {
          return RadioListTile<String>(
            title: Text(choice.text),
            key: ValueKey(choice.text),
            value: choice.value,
            groupValue: initialValue,
            onChanged: (value) {
              onValueChange(value);
            },
          );
        }))
          ..add(getGoButton(context, initialValue)));
  }

  Widget getGoButton(BuildContext context, String value) {
    final Store<AppState> store = StoreProvider.of(context, listen: false);
    final callback = value != null
        ? () => store.dispatch(LoginReloginWithCodeAction(value))
        : null;
    final title = store.state.flavor.get("mission:submit");
    return getMainTextButton(label: title, onPressed: callback);
  }
}
